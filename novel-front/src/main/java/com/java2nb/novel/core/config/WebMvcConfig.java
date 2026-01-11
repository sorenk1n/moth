package com.java2nb.novel.core.config;

import com.java2nb.novel.core.converter.DateConverter;
import com.java2nb.novel.core.interceptor.OpenApiAuthInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.format.FormatterRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @author xiongxiaoyang
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    private final OpenApiAuthInterceptor openApiAuthInterceptor;

    public WebMvcConfig(OpenApiAuthInterceptor openApiAuthInterceptor) {
        this.openApiAuthInterceptor = openApiAuthInterceptor;
    }

    @Override
    public void addFormatters(FormatterRegistry registry) {
        registry.addConverter(new DateConverter());
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(openApiAuthInterceptor).addPathPatterns("/openapi/**");
    }
}
