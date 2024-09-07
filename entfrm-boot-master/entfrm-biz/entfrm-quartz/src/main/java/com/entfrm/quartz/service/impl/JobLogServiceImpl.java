package com.entfrm.quartz.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.entfrm.quartz.entity.JobLog;
import com.entfrm.quartz.mapper.JobLogMapper;
import com.entfrm.quartz.service.JobLogService;

/**
 * 定时任务调度日志信息 服务层
 *
 * @author entfrm
 */
@Service
public class JobLogServiceImpl extends ServiceImpl<JobLogMapper, JobLog> implements JobLogService {

    /**
     * 清空任务日志
     */
    @Override
    public void cleanJobLog() {
        baseMapper.cleanJobLog();
    }
}
