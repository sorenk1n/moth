// TODO: 向运营获取正式的 md5Key / aesKey，可由后端下发到页面；若未下发则使用示例值（不可用于生产）
// 与 application-alipay.yml 中 md5-key / aes-key 保持一致，供前端生成 visitAuth 使用；
// 允许外部通过 window.PAY_MD5_KEY / window.PAY_AES_KEY 注入覆盖，以便动态下发密钥。
const PAY_MD5_KEY = window.PAY_MD5_KEY || "dywtNuTc5K$"; // 自定义验签的 md5Key
const PAY_AES_KEY = window.PAY_AES_KEY || "YG7J4Lpidg457CziIY1nRZn3"; // 自定义验签的 aesKey，长度可为 16/24/32 字节
const RMB_TO_COIN_RATE = 100;
const CUSTOM_MIN = 1;
const CUSTOM_MAX = 5000;

function getQueryParam(key) {
    var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return decodeURIComponent(r[2]);
    return null;
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

function buildVisitAuth(ts) {
    var md5Str = CryptoJS.MD5(PAY_MD5_KEY + ":" + ts).toString();
    return CryptoJS.AES.encrypt(md5Str, CryptoJS.enc.Utf8.parse(PAY_AES_KEY), {
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
    var num = parseInt(amount, 10);
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
    $("#payform").trigger("submit");
}

function handleCustomRmb() {
    var val = parseInt($("#customAmount").val(), 10);
    if (isNaN(val)) {
        layer.alert("请输入有效的整数金额");
        return;
    }
    if (val < CUSTOM_MIN || val > CUSTOM_MAX) {
        layer.alert("金额范围需在 " + CUSTOM_MIN + " - " + CUSTOM_MAX + " 元之间");
        return;
    }
    $("#ulZFWX li").removeClass("on");
    applyRmbAmount(val);
    submitIfAliPaySelected();
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
        var amount = parseInt(payAmount, 10);
        if (!amount || amount <= 0) {
            layer.alert("请选择充值金额");
            return;
        }
        ensureCrypto(function () {
            // 使用秒级时间戳
            var ts = Math.floor(Date.now() / 1000).toString();
            var visitAuth = buildVisitAuth(ts);

            // 仅提交核心字段，避免 passback_params 过长导致 INVALID_PARAMETER
            var payload = {
                payAmount: amount,
                externalId: "888002",
                payChannel: "1",
                typeIndex: "2",
                buyerId: 2088002158995009,
                merchantSubject: "账户充值",
                body: "账户充值",
                returnUrl: PAY_RETURN_URL
            };

            $.ajax({
                type: "post", // 使用 POST 提交支付请求
                url: "/pay/aliPay", // 后端支付接口地址
                headers: {
                    timeStamp: ts, // 时间戳，参与服务端验签
                    visitAuth: visitAuth // 加密后的验签值，服务端校验
                },
                data: payload, // 提交的业务数据（金额、外部ID、回跳等）
                contentType: "application/x-www-form-urlencoded; charset=UTF-8", // 表单编码
                success: function (html) { // 后端返回支付表单 HTML
                    var w = window.open(); // 打开新窗口
                    if (w) {
                        w.document.write(html); // 新窗口写入表单并自动提交
                    } else {
                        document.write(html); // 若被拦截则在当前页写入
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
        $("#ulZFWX li").removeClass("on");
        $(this).addClass("on");
        var amount = $(this).attr("vals");
        if (applyRmbAmount(amount)) {
            submitIfAliPaySelected();
        }
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
        handleCustomRmb();
    });

    $("#customAmount").on("keydown", function (e) {
        if (e.key === "Enter") {
            e.preventDefault();
            handleCustomRmb();
        }
    });
});
