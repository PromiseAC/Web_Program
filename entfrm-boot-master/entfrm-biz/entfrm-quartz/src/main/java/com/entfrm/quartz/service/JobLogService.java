package com.entfrm.quartz.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.entfrm.quartz.entity.JobLog;

/**
 * 定时任务调度日志信息信息 服务层
 *
 * @author entfrm
 */
public interface JobLogService extends IService<JobLog> {

    /**
     * 清空任务日志
     */
    public void cleanJobLog();
}
