// TODO: 向运营获取正式的 md5Key / aesKey，可由后端下发到页面；若未下发则使用示例值（不可用于生产）
const PAY_MD5_KEY = window.PAY_MD5_KEY || "demo-md5-key-123456";
const PAY_AES_KEY = window.PAY_AES_KEY || "demo-aes-key-16b"; // 长度 16/24/32 位均可，示例为 16 位

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
            var ts = Date.now().toString();
            var visitAuth = buildVisitAuth(ts);

            // 仅提交核心字段，避免 passback_params 过长导致 INVALID_PARAMETER
            var payload = {
                payAmount: amount,
                merchantSubject: "账户充值",
                body: "账户充值",
                returnUrl: PAY_RETURN_URL
            };

            $.ajax({
                type: "post",
                url: "/pay/aliPay",
                headers: {
                    timeStamp: ts,
                    visitAuth: visitAuth
                },
                data: payload,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                success: function (html) {
                    var w = window.open();
                    if (w) {
                        w.document.write(html);
                    } else {
                        document.write(html);
                    }
                },
                error: function () {
                    layer.alert("支付请求失败");
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
        if ($(this).attr("vals") > 0) {
            $("#pValue").val($(this).attr("vals"));
            $("#showTotal").html('￥' + $(this).attr("vals") + '元');
            for (var i = 0; i < UserPay.czData.length; i++) {
                if (UserPay.czData[i][0] == $(this).attr("vals")) {
                    $("#showRemark").html(UserPay.czData[i][1]);
                    break;
                }
            }
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
});
