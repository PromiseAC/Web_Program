package com.entfrm.quartz.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.data.util.ExcelUtil;
import com.entfrm.log.annotation.SysLog;
import com.entfrm.quartz.entity.Job;
import com.entfrm.quartz.service.JobService;
import com.entfrm.quartz.util.CronUtils;
import com.entfrm.quartz.util.ScheduleUtils;
import com.entfrm.base.api.R;
import com.entfrm.base.constant.CommonConstants;
import com.entfrm.base.util.StrUtil;
import lombok.AllArgsConstructor;
import org.quartz.SchedulerException;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 调度任务信息操作处理
 *
 * @author entfrm
 */
@RestController
@AllArgsConstructor
@RequestMapping("/quartz/job")
public class JobController {

    private final JobService jobService;

    private QueryWrapper<Job> getQueryWrapper(Job job) {
        return new QueryWrapper<Job>().like(StrUtil.isNotBlank(job.getJobName()), "job_name", job.getJobName()).eq(StrUtil.isNotBlank(job.getJobGroup()), "job_group", job.getJobGroup())
                .like(StrUtil.isNotBlank(job.getInvokeTarget()), "invoke_target", job.getInvokeTarget()).eq(StrUtil.isNotBlank(job.getStatus()), "status", job.getStatus()).orderByDesc("id");
    }

    /**
     * 定时任务分页查询
     *
     * @param page 分页对象
     * @param job  定时任务调度表
     * @return
     */
    @GetMapping("/list")
    public R list(Page page, Job job) {
        IPage<Job> jobPage = jobService.page(page, getQueryWrapper(job));
        return R.ok(jobPage.getRecords(), jobPage.getTotal());
    }

    /**
     * 获取定时任务详细信息
     */
    @GetMapping(value = "/{jobId}")
    public R getInfo(@PathVariable("jobId") Integer jobId) {
        return R.ok(jobService.getById(jobId));
    }

    /**
     * 新增定时任务
     */
    @SaCheckPermission("job_add")
    @SysLog("定时任务新增")
    @PostMapping
    public R save(@RequestBody Job job) throws SchedulerException {
        if (!CronUtils.isValid(job.getCronExpression())) {
            return R.error("新增任务'" + job.getJobName() + "'失败，Cron表达式不正确");
        } else if (StrUtil.containsIgnoreCase(job.getInvokeTarget(), CommonConstants.LOOKUP_RMI)) {
            return R.error("新增任务'" + job.getJobName() + "'失败，目标字符串不允许'rmi'调用");
        } else if (StrUtil.containsAnyIgnoreCase(job.getInvokeTarget(), new String[]{CommonConstants.LOOKUP_LDAP, CommonConstants.LOOKUP_LDAPS})) {
            return R.error("新增任务'" + job.getJobName() + "'失败，目标字符串不允许'ldap(s)'调用");
        } else if (StrUtil.containsAnyIgnoreCase(job.getInvokeTarget(), new String[]{CommonConstants.HTTP, CommonConstants.HTTPS})) {
            return R.error("新增任务'" + job.getJobName() + "'失败，目标字符串不允许'http(s)'调用");
        } else if (StrUtil.containsAnyIgnoreCase(job.getInvokeTarget(), CommonConstants.JOB_ERROR_STR)) {
            return R.error("新增任务'" + job.getJobName() + "'失败，目标字符串存在违规");
        } else if (!ScheduleUtils.whiteList(job.getInvokeTarget())) {
            return R.error("新增任务'" + job.getJobName() + "'失败，目标字符串不在白名单内");
        }
        return R.ok(jobService.insertJob(job));
    }

    /**
     * 修改定时任务
     */
    @SaCheckPermission("job_edit")
    @SysLog("定时任务修改")
    @PutMapping
    public R edit(@RequestBody Job job) throws SchedulerException {
        if (!CronUtils.isValid(job.getCronExpression())) {
            return R.error("修改任务'" + job.getJobName() + "'失败，Cron表达式不正确");
        } else if (StrUtil.containsIgnoreCase(job.getInvokeTarget(), CommonConstants.LOOKUP_RMI)) {
            return R.error("修改任务'" + job.getJobName() + "'失败，目标字符串不允许'rmi'调用");
        } else if (StrUtil.containsAnyIgnoreCase(job.getInvokeTarget(), new String[]{CommonConstants.LOOKUP_LDAP, CommonConstants.LOOKUP_LDAPS})) {
            return R.error("修改任务'" + job.getJobName() + "'失败，目标字符串不允许'ldap(s)'调用");
        } else if (StrUtil.containsAnyIgnoreCase(job.getInvokeTarget(), new String[]{CommonConstants.HTTP, CommonConstants.HTTPS})) {
            return R.error("修改任务'" + job.getJobName() + "'失败，目标字符串不允许'http(s)'调用");
        } else if (StrUtil.containsAnyIgnoreCase(job.getInvokeTarget(), CommonConstants.JOB_ERROR_STR)) {
            return R.error("修改任务'" + job.getJobName() + "'失败，目标字符串存在违规");
        } else if (!ScheduleUtils.whiteList(job.getInvokeTarget())) {
            return R.error("修改任务'" + job.getJobName() + "'失败，目标字符串不在白名单内");
        }
        return R.ok(jobService.updateJob(job));
    }

    /**
     * 定时任务状态修改
     */
    @SaCheckPermission("job_changeStatus")
    @SysLog("定时任务状态修改")
    @PutMapping("/changeStatus")
    public R changeStatus(@RequestBody Job job) throws SchedulerException {
        Job newJob = jobService.getById(job.getId());
        newJob.setStatus(job.getStatus());
        return R.ok(jobService.changeStatus(newJob));
    }

    /**
     * 定时任务立即执行一次
     */
    @SaCheckPermission("job_changeStatus'")
    @SysLog("定时任务立即执行一次")
    @PutMapping("/run")
    public R run(@RequestBody Job job) throws SchedulerException {
        jobService.run(job);
        return R.ok();
    }

    /**
     * 删除定时任务
     */
    @SaCheckPermission("job_del")
    @SysLog("删除定时任务")
    @DeleteMapping("/{jobIds}")
    public R remove(@PathVariable Integer[] jobIds) throws SchedulerException {
        jobService.deleteJobByIds(jobIds);
        return R.ok();
    }

    /**
     * 导出定时任务列表
     */
    @SaCheckPermission("job_export")
    @SysLog("定时任务导出")
    @GetMapping("/export")
    public void export(Job job, ModelMap map, HttpServletRequest request, HttpServletResponse response) {
        List<Job> list = jobService.list(getQueryWrapper(job));
        ExcelUtil.exportExcel("定时任务", list, Job.class, map, request, response);
    }
}
