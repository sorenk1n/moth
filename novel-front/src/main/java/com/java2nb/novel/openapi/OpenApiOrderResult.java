package com.java2nb.novel.openapi;

import lombok.Data;

@Data
public class OpenApiOrderResult {
    private String orderNo;
    private String externalOrderNo;
    private String status;
    private String payType;
    private PayData payData;
    private Long userId;

    @Data
    public static class PayData {
        private String gatewayUrl;
        private String body;
        private java.util.Map<String, String> headers;
    }
}
