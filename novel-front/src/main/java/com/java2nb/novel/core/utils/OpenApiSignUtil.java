package com.java2nb.novel.core.utils;

import java.nio.charset.StandardCharsets;
import java.util.Map;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.binary.Hex;

public final class OpenApiSignUtil {
    private OpenApiSignUtil() {
    }

    public static String hmacSha256(String secret, String content) {
        try {
            Mac mac = Mac.getInstance("HmacSHA256");
            SecretKeySpec keySpec = new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
            mac.init(keySpec);
            byte[] result = mac.doFinal(content.getBytes(StandardCharsets.UTF_8));
            return Hex.encodeHexString(result);
        } catch (Exception ex) {
            throw new IllegalStateException("hmac sign error", ex);
        }
    }

    public static String buildCanonicalString(Map<String, String> params) {
        StringBuilder builder = new StringBuilder();
        params.keySet().stream().sorted().forEach(key -> {
            String value = params.get(key);
            if (value == null) {
                return;
            }
            if (builder.length() > 0) {
                builder.append("&");
            }
            builder.append(key).append("=").append(value);
        });
        return builder.toString();
    }
}
