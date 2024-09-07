package com.entfrm.quartz.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.base.util.StrUtil;
import com.entfrm.data.util.ExcelUtil;
import com.entfrm.log.annotation.SysLog;
import com.entfrm.quartz.entity.Job;
import com.entfrm.quartz.entity.JobLog;
import com.entfrm.quartz.service.JobLogService;
import lombok.AllArgsConstructor;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;

/**
 * 调度日志操作处理
 *
 * @author entfrm
 */
@RestController
@AllArgsConstructor
@RequestMapping("/quartz/jobLog")
public class JobLogController {

    private final JobLogService jobLogService;

    private QueryWrapper<JobLog> getQueryWrapper(JobLog jobLog) {
        return new QueryWrapper<JobLog>().like(StrUtil.isNotBlank(jobLog.getJobName()), "job_name", jobLog.getJobName()).like(StrUtil.isNotBlank(jobLog.getJobGroup()), "job_group", jobLog.getJobGroup()).eq(StrUtil.isNotBlank(jobLog.getStatus()), "status", jobLog.getStatus())
                .like(StrUtil.isNotBlank(jobLog.getInvokeTarget()), "invoke_target", jobLog.getInvokeTarget());
    }

    /**
     * 查询定时任务调度日志列表
     */
    @GetMapping("/list")
    public R list(Page page, JobLog jobLog) {
        IPage<JobLog> jobLogPage = jobLogService.page(page, getQueryWrapper(jobLog));
        return R.ok(jobLogPage.getRecords(), jobLogPage.getTotal());
    }

    /**
     * 根据调度编号获取详细信息
     */
    @SaCheckPermission("jobLog_view")
    @GetMapping(value = "/{id}")
    public R getInfo(@PathVariable Integer id) {
        return R.ok(jobLogService.getById(id));
    }

    /**
     * 删除定时任务调度日志
     */
    @SaCheckPermission("jobLog_del")
    @SysLog("删除定时任务日志")
    @DeleteMapping("/{jobLogIds}")
    public R remove(@PathVariable Integer[] id) {
        return R.ok(jobLogService.removeByIds(Arrays.asList(id)));
    }

    /**
     * 清空定时任务调度日志
     */
    @SaCheckPermission("jobLog_del")
    @SysLog("清空定时任务日志")
    @DeleteMapping("/clean")
    public R clean() {
        jobLogService.cleanJobLog();
        return R.ok();
    }

    /**
     * 导出定时任务调度日志列表
     */
    @SaCheckPermission("jobLog_export")
    @SysLog("定时任务日志导出")
    @GetMapping("/export")
    public void export(JobLog jobLog, ModelMap map, HttpServletRequest request, HttpServletResponse response) {
        List<JobLog> list = jobLogService.list(getQueryWrapper(jobLog));
        ExcelUtil.exportExcel("调度日志", list, JobLog.class, map, request, response);
    }
}
