package com.entfrm.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.entfrm.system.entity.Application;
import com.entfrm.system.mapper.ApplicationMapper;
import com.entfrm.system.service.ApplicationService;
import org.springframework.stereotype.Service;

/**
 * @author entfrm
 * @date 2020-04-23 18:15:10
 * @description 应用Service业务层
 */
@Service
public class ApplicationServiceImpl extends ServiceImpl<ApplicationMapper, Application> implements ApplicationService {
}
