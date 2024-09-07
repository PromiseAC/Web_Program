package com.entfrm.quartz.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.entfrm.quartz.entity.JobLog;

/**
 * 调度任务日志信息 数据层
 *
 * @author entfrm
 */
public interface JobLogMapper extends BaseMapper<JobLog> {

    /**
     * 清空任务日志
     */
    public void cleanJobLog();
}
