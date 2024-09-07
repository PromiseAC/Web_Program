package com.entfrm.quartz.util;

import cn.hutool.extra.spring.SpringUtil;
import com.entfrm.base.constant.CommonConstants;
import com.entfrm.base.exception.BaseException;
import com.entfrm.base.util.StrUtil;
import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import com.entfrm.quartz.entity.Job;

/**
 * 定时任务工具类
 *
 * @author entfrm
 */
public class ScheduleUtils {
    /**
     * 得到quartz任务类
     *
     * @param job 执行计划
     * @return 具体执行任务类
     */
    private static Class<? extends org.quartz.Job> getQuartzJobClass(Job job) {
        boolean isConcurrent = "0".equals(job.getConcurrent());
        return isConcurrent ? QuartzJobExecution.class : QuartzDisallowConcurrentExecution.class;
    }

    /**
     * 构建任务触发对象
     */
    public static TriggerKey getTriggerKey(Integer jobId, String jobGroup) {
        return TriggerKey.triggerKey("TASK_CLASS_NAME" + jobId, jobGroup);
    }

    /**
     * 构建任务键对象
     */
    public static JobKey getJobKey(Integer jobId, String jobGroup) {
        return JobKey.jobKey("TASK_CLASS_NAME" + jobId, jobGroup);
    }

    /**
     * 创建定时任务
     */
    public static void createScheduleJob(Scheduler scheduler, Job job) throws SchedulerException {
        Class<? extends org.quartz.Job> jobClass = getQuartzJobClass(job);
        // 构建job信息
        Integer jobId = job.getId();
        String jobGroup = job.getJobGroup();
        JobDetail jobDetail = JobBuilder.newJob(jobClass).withIdentity(getJobKey(jobId, jobGroup)).build();

        // 表达式调度构建器
        CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder.cronSchedule(job.getCronExpression());
        cronScheduleBuilder = handleCronScheduleMisfirePolicy(job, cronScheduleBuilder);

        // 按新的cronExpression表达式构建一个新的trigger
        CronTrigger trigger = TriggerBuilder.newTrigger().withIdentity(getTriggerKey(jobId, jobGroup))
                .withSchedule(cronScheduleBuilder).build();

        // 放入参数，运行时的方法可以获取
        jobDetail.getJobDataMap().put("TASK_PROPERTIES", job);

        // 判断是否存在
        if (scheduler.checkExists(getJobKey(jobId, jobGroup))) {
            // 防止创建时存在数据问题 先移除，然后在执行创建操作
            scheduler.deleteJob(getJobKey(jobId, jobGroup));
        }

        scheduler.scheduleJob(jobDetail, trigger);

        // 暂停任务
        if (job.getStatus().equals("1")) {
            scheduler.pauseJob(ScheduleUtils.getJobKey(jobId, jobGroup));
        }
    }

    /**
     * 设置定时任务策略
     */
    public static CronScheduleBuilder handleCronScheduleMisfirePolicy(Job job, CronScheduleBuilder cb) {
        switch (job.getMisfirePolicy()) {
            case "0"://默认
                return cb;
            case "1"://立即触发执行
                return cb.withMisfireHandlingInstructionIgnoreMisfires();
            case "2"://触发一次执行
                return cb.withMisfireHandlingInstructionFireAndProceed();
            case "3"://不触发立即执行
                return cb.withMisfireHandlingInstructionDoNothing();
            default:
                throw new BaseException("The task misfire policy '" + job.getMisfirePolicy() + "' cannot be used in cron schedule tasks");
        }
    }

    /**
     * 检查包名是否为白名单配置
     *
     * @param invokeTarget 目标字符串
     * @return 结果
     */
    public static boolean whiteList(String invokeTarget) {
        String packageName = StrUtil.subBefore(invokeTarget, "(", false);
        int count = StrUtil.count(packageName, ".");
        if (count > 1) {
            return StrUtil.containsAnyIgnoreCase(invokeTarget, CommonConstants.JOB_WHITELIST_STR);
        }
        String beanName = StrUtil.split(invokeTarget, ".").get(0);
        Object obj = SpringUtil.getBean(beanName);
        return StrUtil.containsAnyIgnoreCase(obj.getClass().getPackage().getName(), CommonConstants.JOB_WHITELIST_STR);
    }
}
