function statusText(status) {
    if (status === 1) return "正常";
    if (status === 2) return "风控";
    if (status === 0) return "禁用";
    return "未知";
}

function statusColor(status) {
    if (status === 1) return "#2a9d8f";
    if (status === 2) return "#e76f51";
    if (status === 0) return "#999";
    return "#666";
}

var merchantListCache = [];
var merchantPage = 1;
var merchantPageSize = 10;
var lastDefaultSwitchAt = 0;
var DEFAULT_SWITCH_COOLDOWN_MS = 60 * 1000;

function loadMerchants() {
    $.get("/merchant/list", function (resp) {
        if (!resp || resp.code !== 200) {
            layer.alert(resp ? resp.msg : "加载失败");
            return;
        }
        merchantListCache = resp.data || [];
        merchantPage = 1;
        renderPagedMerchants();
    });
}

function loadCurrentMerchant() {
    $.get("/merchant/default", function (resp) {
        if (!resp || resp.code !== 200) {
            $("#currentMerchantLabel").text("加载失败");
            return;
        }
        renderCurrentMerchant(resp.data);
    });
}

function renderCurrentMerchant(merchant) {
    if (!merchant) {
        $("#currentMerchantLabel").text("未设置默认商户");
        $("#currentMerchantStatus").text("");
        return;
    }
    var name = merchant.name || merchant.remark || "商户";
    //var label = "商户全称：" + name;
    if (merchant.alipayMerchantNo) {
        name += " -- simId " + merchant.alipayMerchantNo;
    }
    $("#currentMerchantLabel").text(name);
    $("#currentMerchantStatus").html("<span style=\"color:" + statusColor(merchant.status) + "\">"
        + statusText(merchant.status) + "</span>");
}

function renderMerchants(list) {
    var $tbody = $("#merchantTbody");
    $tbody.empty();
    list.forEach(function (m) {
        var name = (m.name || m.remark || "");
        var statusLabel = "<span style=\"color:" + statusColor(m.status) + "\">" + statusText(m.status) + "</span>";
        var isDefault = m.isDefault === 1 ? "（当前）" : "";
        var statusEditor = [
            "<span class=\"statusEditor\" data-id=\"" + m.id + "\" style=\"cursor:pointer;\">",
            statusLabel,
            "</span>"
        ].join("");
        var row = [
            "<tr data-id=\"" + m.id + "\">",
            "<td style=\"padding:8px;border-bottom:1px solid #f1f1f1;\">" + name + isDefault + "</td>",
            "<td style=\"padding:8px;border-bottom:1px solid #f1f1f1;\">" + (m.alipayMerchantNo || "") + "</td>",
            "<td style=\"padding:8px;border-bottom:1px solid #f1f1f1;\">" + (m.md5Key || "") + "</td>",
            "<td style=\"padding:8px;border-bottom:1px solid #f1f1f1;\">" + (m.aesKey || "") + "</td>",
            "<td style=\"padding:8px;border-bottom:1px solid #f1f1f1;\">" + statusEditor + "</td>",
            "<td style=\"padding:8px;border-bottom:1px solid #f1f1f1;\">",
            "<a href=\"javascript:void(0);\" class=\"btn_default\" data-id=\"" + m.id + "\">设为默认</a>",
            "</td>",
            "</tr>"
        ].join("");
        $tbody.append(row);
    });
}

function renderPagedMerchants() {
    var total = merchantListCache.length;
    var totalPages = Math.max(1, Math.ceil(total / merchantPageSize));
    if (merchantPage > totalPages) {
        merchantPage = totalPages;
    }
    var start = (merchantPage - 1) * merchantPageSize;
    var end = start + merchantPageSize;
    var pageList = merchantListCache.slice(start, end);
    renderMerchants(pageList);
    $("#merchantPageInfo").text("第 " + merchantPage + " / " + totalPages + " 页");
    $("#merchantPrev").prop("disabled", merchantPage <= 1);
    $("#merchantNext").prop("disabled", merchantPage >= totalPages);
}

function setDefault(id) {
    var now = Date.now();
    if (lastDefaultSwitchAt && (now - lastDefaultSwitchAt) < DEFAULT_SWITCH_COOLDOWN_MS) {
        layer.alert("一分钟内不能多次修改全局商户，请稍后操作");
        return;
    }
    $.post("/merchant/setDefault", { id: id }, function (resp) {
        if (!resp || resp.code !== 200) {
            layer.alert(resp ? resp.msg : "设置失败");
            return;
        }
        lastDefaultSwitchAt = Date.now();
        merchantListCache.forEach(function (item) {
            item.isDefault = (item.id === id) ? 1 : 0;
        });
        layer.alert("已切换全局商户");
        loadCurrentMerchant();
        renderPagedMerchants();
    });
}

function updateStatus(id, status) {
    $.post("/merchant/updateStatus", { id: id, status: status }, function (resp) {
        if (!resp || resp.code !== 200) {
            layer.alert(resp ? resp.msg : "更新失败");
            return;
        }
        merchantListCache.forEach(function (item) {
            if (item.id === id) {
                item.status = Number(status);
            }
        });
        loadCurrentMerchant();
        renderPagedMerchants();
    });
}

$(function () {
    loadCurrentMerchant();
    loadMerchants();

    $("#merchantTbody").on("click", ".btn_default", function () {
        var id = $(this).data("id");
        layer.confirm("确认切换商户？", function () {
            setDefault(id);
        });
    });

    $("#merchantTbody").on("click", ".statusEditor", function () {
        var id = $(this).data("id");
        layer.open({
            type: 1,
            title: "选择状态",
            area: ["260px", "220px"],
            shadeClose: true,
            content: [
                "<div style=\"padding:16px;\">",
                "<button type=\"button\" class=\"btn_status_choose\" data-id=\"" + id + "\" data-status=\"1\" style=\"height:32px;width:100%;margin-bottom:8px;\">正常</button>",
                "<button type=\"button\" class=\"btn_status_choose\" data-id=\"" + id + "\" data-status=\"2\" style=\"height:32px;width:100%;margin-bottom:8px;\">风控</button>",
                "<button type=\"button\" class=\"btn_status_choose\" data-id=\"" + id + "\" data-status=\"0\" style=\"height:32px;width:100%;\">禁用</button>",
                "</div>"
            ].join("")
        });
    });

    $(document).on("click", ".btn_status_choose", function () {
        var id = $(this).data("id");
        var status = $(this).data("status");
        updateStatus(id, status);
        layer.closeAll();
    });

    $("#merchantPrev").on("click", function () {
        if (merchantPage > 1) {
            merchantPage -= 1;
            renderPagedMerchants();
        }
    });

    $("#merchantNext").on("click", function () {
        var totalPages = Math.max(1, Math.ceil(merchantListCache.length / merchantPageSize));
        if (merchantPage < totalPages) {
            merchantPage += 1;
            renderPagedMerchants();
        }
    });

    $("#merchantPageSize").on("change", function () {
        merchantPageSize = parseInt($(this).val(), 10) || 10;
        merchantPage = 1;
        renderPagedMerchants();
    });
});
