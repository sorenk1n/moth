package com.java2nb.novel.service;

import com.java2nb.novel.entity.OpenApiNotifyTask;
import com.java2nb.novel.mapper.OpenApiNotifyTaskMapper;
import com.java2nb.common.utils.Query;
import java.util.Date;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OpenApiNotifyTaskService {

    private final OpenApiNotifyTaskMapper openApiNotifyTaskMapper;

    public List<OpenApiNotifyTask> list(Query query) {
        Integer status = parseStatus(query.get("status"));
        int offset = query.getOffset();
        int limit = query.getLimit();
        return openApiNotifyTaskMapper.list(status, offset, limit);
    }

    public int count(Query query) {
        Integer status = parseStatus(query.get("status"));
        return openApiNotifyTaskMapper.count(status);
    }

    public int retry(Long id) {
        return openApiNotifyTaskMapper.resetForRetry(id, new Date());
    }

    private Integer parseStatus(Object value) {
        if (value == null) {
            return null;
        }
        String str = String.valueOf(value);
        if (StringUtils.isBlank(str)) {
            return null;
        }
        try {
            return Integer.parseInt(str);
        } catch (NumberFormatException ex) {
            return null;
        }
    }
}
