// TODO: 向运营获取正式的 md5Key / aesKey，可由后端下发到页面；若未下发则使用示例值（不可用于生产）
// 与 application-alipay.yml 中 md5-key / aes-key 保持一致，供前端生成 visitAuth 使用；
// 允许外部通过 window.PAY_MD5_KEY / window.PAY_AES_KEY 注入覆盖，以便动态下发密钥。
const PAY_MD5_KEY = window.PAY_MD5_KEY || "cxTWgAyMrtTiYEiH"; // 自定义验签的 md5Key
const PAY_AES_KEY = window.PAY_AES_KEY || "cxTWgAyMrtTiYEiH"; // 自定义验签的 aesKey，长度可为 16/24/32 字节
const RMB_TO_COIN_RATE = 100;
const CUSTOM_MIN = 0.1;
const CUSTOM_MAX = 5000;
const DEFAULT_MERCHANT_NO = "888007";
let merchantLoaded = false;
let merchantsCache = [];
let defaultMerchantCache = null;

function getQueryParam(key) {
    var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return decodeURIComponent(r[2]);
    return null;
}

function isMobileDevice() {
    var ua = (navigator.userAgent || "").toLowerCase();
    return ua.indexOf("mobile") !== -1
        || ua.indexOf("android") !== -1
        || ua.indexOf("iphone") !== -1
        || ua.indexOf("ipad") !== -1
        || ua.indexOf("ipod") !== -1
        || ua.indexOf("windows phone") !== -1;
}

// 若页面未内置 CryptoJS，则按需从本地静态资源加载
function ensureCrypto(callback) {
    if (window.CryptoJS) {
        callback();
        return;
    }
    $.getScript("/javascript/crypto-js.min.js")
        .done(callback)
        .fail(function () {
            layer.alert("加密库加载失败，请检查本地静态资源 /javascript/crypto-js.min.js 是否存在");
        });
}

function renderMerchants(list) {
    var $select = $("#merchantSelect");
    if (!$select.length) {
        return;
    }
    $select.empty();
    list.forEach(function (m, idx) {
        var opt = $("<option>").val(m.merchantNo).text(buildMerchantLabel(m));
        $select.append(opt);
    });
    if (!$select.val() && list.length > 0) {
        $select.val(list[0].merchantNo);
    }
}

function buildMerchantLabel(merchant) {
    var name = (merchant && merchant.remark) ? merchant.remark : (merchant && merchant.name ? merchant.name : "商户");
    var alipayNo = merchant && merchant.alipayMerchantNo ? merchant.alipayMerchantNo : "";
    var fallbackNo = merchant && merchant.merchantNo ? merchant.merchantNo : "";
    var tailSource = alipayNo || fallbackNo;
    var tail = tailSource ? tailSource.slice(-4) : "";
    var merchantNo = merchant && merchant.merchantNo ? merchant.merchantNo : "";
    var label = tail ? (name + "（尾号" + tail + "）") : name;
    if (merchantNo) {
        label += " / 商户号" + merchantNo;
    }
    return label;
}

function renderDefaultMerchant(merchant) {
    var $label = $("#merchantLabel");
    if (!$label.length) {
        return;
    }
    if (!merchant) {
        $label.text("当前商户：默认商户");
        $("#merchantRiskTip").hide();
        return;
    }
    $label.text("当前商户：" + buildMerchantLabel(merchant));
    if (Number(merchant.status) === 2) {
        $("#merchantRiskTip").show();
    } else {
        $("#merchantRiskTip").hide();
    }
}

function loadDefaultMerchant() {
    $.ajax({
        type: "get",
        url: "/merchant/default",
        dataType: "json",
        success: function (resp) {
            if (resp && resp.code === 200) {
                defaultMerchantCache = resp.data || null;
                if (!defaultMerchantCache) {
                    loadMerchants();
                }
                renderDefaultMerchant(defaultMerchantCache);
            }
        },
        error: function () {
            loadMerchants();
        }
    });
}

function loadMerchants() {
    var $select = $("#merchantSelect");
    $.ajax({
        type: "get",
        url: "/pay/merchants",
        dataType: "json",
        success: function (resp) {
            if (resp && resp.code === 200 && resp.data) {
                merchantsCache = resp.data;
                if (merchantsCache.length > 0) {
                    if ($select.length) {
                        renderMerchants(merchantsCache);
                    }
                    if (!defaultMerchantCache) {
                        defaultMerchantCache = merchantsCache[0];
                        renderDefaultMerchant(defaultMerchantCache);
                    }
                    merchantLoaded = true;
                }
            }
        },
        error: function () {
            // 使用默认值，不阻塞
        }
    });
}

function buildVisitAuth(ts, md5Key, aesKey) {
    var md5Str = CryptoJS.MD5(md5Key + ":" + ts).toString();
    return CryptoJS.AES.encrypt(md5Str, CryptoJS.enc.Utf8.parse(aesKey), {
        mode: CryptoJS.mode.ECB,
        padding: CryptoJS.pad.Pkcs7
    }).toString(); // Base64
}

// 阿里接口常用时间戳格式 yyyy-MM-dd HH:mm:ss
function formatTimestamp() {
    var d = new Date();
    var pad = function (n) { return n < 10 ? ("0" + n) : n; };
    return d.getFullYear() + "-" + pad(d.getMonth() + 1) + "-" + pad(d.getDate()) + " " +
        pad(d.getHours()) + ":" + pad(d.getMinutes()) + ":" + pad(d.getSeconds());
}

function updateRmbCheckout(amount) {
    if ($("#showTotal").length) {
        $("#showTotal").html("￥" + amount + "元");
    }
    if ($("#showRemark").length) {
        $("#showRemark").html((amount * RMB_TO_COIN_RATE) + "屋币");
    }
}

function applyRmbAmount(amount) {
    var num = parseFloat(amount);
    if (!num || num <= 0) {
        return null;
    }
    $("#pValue").val(num);
    updateRmbCheckout(num);
    return num;
}

function submitIfAliPaySelected() {
    var payType = $("#ulPayType").find("li.on").attr("valp");
    if (payType === "2") {
        layer.alert("微信支付暂未开通，敬请期待");
        return;
    }
    if (defaultMerchantCache && Number(defaultMerchantCache.status) === 2) {
        layer.confirm("当前商户为风控状态，是否继续支付？", function () {
            $("#payform").trigger("submit");
        });
        return;
    }
    $("#payform").trigger("submit");
}

function handleCustomRmb() {
    var val = parseFloat($("#customAmount").val());
    if (isNaN(val)) {
        layer.alert("请输入有效的整数金额");
        return;
    }
    if (val < CUSTOM_MIN || val > CUSTOM_MAX) {
        layer.alert("金额范围需在 " + CUSTOM_MIN + " - " + CUSTOM_MAX + " 元之间");
        return;
    }
    $("#ulZFWX li").removeClass("on");
    $("#ulZFWX").find("li[data-type='custom']").addClass("on");
    applyRmbAmount(val);
}

function getSelectedAmount() {
    var $selected = $("#ulZFWX").find("li.on");
    if (!$selected.length) {
        return null;
    }
    if ($selected.data("type") === "custom") {
        var custom = parseFloat($("#customAmount").val());
        if (isNaN(custom)) {
            layer.alert("请输入有效的整数金额");
            return null;
        }
        if (custom < CUSTOM_MIN || custom > CUSTOM_MAX) {
            layer.alert("金额范围需在 " + CUSTOM_MIN + " - " + CUSTOM_MAX + " 元之间");
            return null;
        }
        return custom;
    }
    var preset = parseFloat($selected.attr("vals"));
    return (!preset || preset <= 0) ? null : preset;
}

// 支付完成后的回跳地址：优先 originUrl 参数，其次上一页，否则默认用户中心
var PAY_RETURN_URL = (function () {
    var url = getQueryParam("originUrl");
    if (url) {
        return url;
    }
    if (document.referrer) {
        return document.referrer;
    }
    return window.location.origin + "/user/userinfo.html";
})();

var UserPay = {
    czData: [[30, "3000屋币"], [50, "5000屋币"], [100, "10000屋币"], [200, "20000屋币"], [500, "50000屋币"], [365, "全站包年阅读"] ],
    czPayPalData: [[20, "10000屋币"], [50, "25000屋币"], [100, "50000屋币"], [80, "全站包年阅读"]],
    sendPay: function () {
        var payAmount = $("#pValue").val();
        //var amount = parseInt(payAmount, 10);
        var amount = parseFloat(payAmount);
        if (!amount || amount <= 0) {
            layer.alert("请选择充值金额");
            return;
        }
        var merchantNo = (defaultMerchantCache && defaultMerchantCache.merchantNo)
            || $("#merchantSelect").val()
            || DEFAULT_MERCHANT_NO;
        ensureCrypto(function () {
            var md5Key = (defaultMerchantCache && defaultMerchantCache.md5Key) || PAY_MD5_KEY;
            var aesKey = (defaultMerchantCache && defaultMerchantCache.aesKey) || PAY_AES_KEY;
            // 使用秒级时间戳
            var ts = Math.floor(Date.now() / 1000).toString();
            var visitAuth = buildVisitAuth(ts, md5Key, aesKey);

            // 仅提交核心字段，避免 passback_params 过长导致 INVALID_PARAMETER
            var payload = {
                payAmount: amount,
                externalId: merchantNo,
                payChannel: "1",
                typeIndex: "2",
                totalAmount: amount.toString(), // 网关必填，后端也会兜底补充
                externalGoodsType: "9",
                clientType: isMobileDevice() ? "mobile" : "pc"
            };
            if (isMobileDevice()) {
                payload.qrPayMode = "1";
                payload.qrcodeWidth = "200";
            }

            $.ajax({
                type: "post", // 使用 POST 提交支付请求
                url: "/pay/aliPay", // 后端支付接口地址
                headers: {
                    timeStamp: ts, // 时间戳，参与服务端验签
                    visitAuth: visitAuth // 加密后的验签值，服务端校验
                },
                data: payload, // 提交的业务数据（金额、外部ID、回跳等）
                contentType: "application/x-www-form-urlencoded; charset=UTF-8", // 表单编码
                success: function (resp) { // 后端返回支付表单 HTML 或 JSON（包含 pay_url）
                    try {
                        var data = (typeof resp === "string") ? JSON.parse(resp) : resp;
                        var payUrl = data && data.data && data.data.data && data.data.data.pay_url;
                        if (payUrl) {
                            window.location.href = payUrl;
                            return;
                        }
                        // 无 pay_url 时提示返回内容
                        layer.alert(JSON.stringify(data));
                        return;
                    } catch (e) {
                        // 不是 JSON，按表单处理
                    }
                    // 兼容旧的表单 HTML 返回
                    var w = window.open(); // 打开新窗口
                    if (w) {
                        w.document.write(resp); // 新窗口写入表单并自动提交
                    } else {
                        document.write(resp); // 若被拦截则在当前页写入
                    }
                },
                error: function () {
                    layer.alert("支付请求失败"); // 异常或 4xx/5xx 提示
                }
            });
        });
    }
};

$(function () {
    // 阻止表单原生提交，统一走 AJAX，确保自定义 header 传递
    $("#payform").on("submit", function (e) {
        e.preventDefault();
        UserPay.sendPay();
    });

    // 加载默认商户
    loadDefaultMerchant();

    // 默认选中第一个金额，回显汇总
    var defaultLi = $("#ulZFWX li").first();
    if (defaultLi.length) {
        defaultLi.addClass("on");
        applyRmbAmount(defaultLi.attr("vals"));
    }

    $("#ulPayType li").click(function () {

        if($(this).attr("valp")==2){
            layer.alert("微信支付暂未开通，敬请期待");
        }

        return ;



        $($(this).parent()).children().each(function () {
            $(this).removeClass("on");
        });
        $(this).addClass("on");

        var type = $(this).attr("valp");
        if (type == "3") {
            $("#ulPayPal").show();
            $("#ulPayPalXJ").show();
            $("#ulZFWX").hide();
            $("#ulZFWXXJ").hide();
        }
        else {
            $("#ulPayPal").hide();
            $("#ulPayPalXJ").hide();
            $("#ulZFWX").show();
            $("#ulZFWXXJ").show();
        }

    })

    $("#ulZFWX li").click(function () {
        if ($(this).data("type") === "custom") {
            $("#customAmount").focus();
            $("#ulZFWX li").removeClass("on");
            $(this).addClass("on");
            return;
        }
        $("#ulZFWX li").removeClass("on");
        $(this).addClass("on");
        var amount = $(this).attr("vals");
        applyRmbAmount(amount);
    });
    $("#ulPayPal li").click(function () {
        $("#ulPayPal li").removeClass("on");
        $(this).addClass("on");
        if ($(this).attr("vals") > 0) {
            $("#pValue").val($(this).attr("vals"));
            $("#showPayPalTotal").html($(this).attr("vals") + '美元');
            for (var i = 0; i < UserPay.czData.length; i++) {
                if (UserPay.czPayPalData[i][0] == $(this).attr("vals")) {
                    $("#showPayPalRemark").html(UserPay.czPayPalData[i][1]);
                    break;
                }
            }
        }
    });

    $("#btnUseCustom").on("click", function () {
        var amount = getSelectedAmount();
        if (!amount) {
            layer.alert("请选择充值金额");
            return;
        }
        if (applyRmbAmount(amount)) {
            submitIfAliPaySelected();
        }
    });

    $("#customAmount").on("keydown", function (e) {
        if (e.key === "Enter") {
            e.preventDefault();
            $("#btnUseCustom").trigger("click");
        }
    });

    $("#customAmount").on("focus", function () {
        $("#ulZFWX li").removeClass("on");
        $("#ulZFWX").find("li[data-type='custom']").addClass("on");
    });
});
