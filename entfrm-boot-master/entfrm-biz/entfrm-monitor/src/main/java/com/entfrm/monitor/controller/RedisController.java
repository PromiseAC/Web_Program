package com.entfrm.monitor.controller;

import com.entfrm.base.constant.AppConstants;
import com.entfrm.monitor.service.RedisService;
import com.entfrm.base.api.R;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author entfrm
 * @date 2020-05-16
 * @description redis数据
 */
@RestController
@AllArgsConstructor
@RequestMapping(AppConstants.APP_MONITOR + "/redis")
public class RedisController {

    private final RedisService redisService;

    @GetMapping()
    public R getInfo() {
        return R.ok(redisService.getInfo());
    }
}
