package com.java2nb.novel.core.schedule;

import com.java2nb.novel.openapi.OpenApiNotifyService;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class OpenApiNotifySchedule {

    private final OpenApiNotifyService openApiNotifyService;

    // @Scheduled(fixedDelay = 3000)
    public void processNotifyTasks() {
        openApiNotifyService.processDueTasks(50);
    }
}
