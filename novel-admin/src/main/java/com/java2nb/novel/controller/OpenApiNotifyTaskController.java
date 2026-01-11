package com.java2nb.novel.controller;

import com.java2nb.common.utils.PageBean;
import com.java2nb.common.utils.Query;
import com.java2nb.common.utils.R;
import com.java2nb.novel.entity.OpenApiNotifyTask;
import com.java2nb.novel.service.OpenApiNotifyTaskService;
import java.util.List;
import java.util.Map;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/novel/openapiNotifyTask")
public class OpenApiNotifyTaskController {

    @Autowired
    private OpenApiNotifyTaskService openApiNotifyTaskService;

    @ResponseBody
    @GetMapping("/list")
    @RequiresPermissions("novel:openapiNotifyTask:list")
    public R list(@RequestParam Map<String, Object> params) {
        Query query = new Query(params);
        List<OpenApiNotifyTask> list = openApiNotifyTaskService.list(query);
        int total = openApiNotifyTaskService.count(query);
        PageBean pageBean = new PageBean(list, total);
        return R.ok().put("data", pageBean);
    }

    @ResponseBody
    @PostMapping("/retry")
    @RequiresPermissions("novel:openapiNotifyTask:retry")
    public R retry(@RequestParam("id") Long id) {
        if (id == null) {
            return R.error();
        }
        return openApiNotifyTaskService.retry(id) > 0 ? R.ok() : R.error();
    }
}
