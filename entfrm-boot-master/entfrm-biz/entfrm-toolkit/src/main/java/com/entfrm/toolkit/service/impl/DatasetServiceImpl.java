package com.entfrm.toolkit.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.entfrm.toolkit.entity.Dataset;
import com.entfrm.toolkit.mapper.DatasetMapper;
import com.entfrm.toolkit.service.DatasetService;
import org.springframework.stereotype.Service;

/**
 * @author entfrm
 * @date 2020-06-12 21:56:29
 * @description 数据源Service业务层
 */
@Service
public class DatasetServiceImpl extends ServiceImpl<DatasetMapper, Dataset> implements DatasetService {
}
