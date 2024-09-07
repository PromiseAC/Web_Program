package com.entfrm.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.entfrm.system.entity.FileInfo;
import com.entfrm.system.mapper.FileInfoMapper;
import com.entfrm.system.service.FileInfoService;
import org.springframework.stereotype.Service;

/**
 * @author entfrm
 * @date 2019-09-30 14:17:03
 *
 * @description 文件Service业务层
 */
@Service
public class FileInfoServiceImpl extends ServiceImpl<FileInfoMapper, FileInfo> implements FileInfoService {

}
