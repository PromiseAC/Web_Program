package com.entfrm.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.base.constant.AppConstants;
import com.entfrm.system.entity.Config;
import com.entfrm.system.service.ConfigService;
import com.entfrm.log.annotation.SysLog;
import lombok.AllArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

/**
 * 参数信息
 *
 * @author entfrm
 */
@RestController
@AllArgsConstructor
@RequestMapping(AppConstants.APP_SYSTEM + "/config")
public class ConfigController {

    private final ConfigService configService;

    private QueryWrapper<Config> getQueryWrapper(Config config) {
        return new QueryWrapper<Config>().like(StrUtil.isNotBlank(config.getName()), "name", config.getName()).orderByDesc("id")
                .eq(StrUtil.isNotBlank(config.getKey()), "`key`", config.getKey()).eq(StrUtil.isNotBlank(config.getIsSys()), "is_sys", config.getIsSys());
    }

    @SaCheckPermission("config_view")
    @GetMapping("/list")
    @ResponseBody
    public R list(Page page, Config config) {
        IPage<Config> configPage = configService.page(page, getQueryWrapper(config));
        return R.ok(configPage.getRecords(), configPage.getTotal());
    }

    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(configService.getById(id));
    }

    @GetMapping("/getByKey/{key}")
    public R getByKey(@PathVariable("key") String key) {
        return R.ok(configService.getValueByKey(key));
    }


    @SysLog("参数新增")
    @SaCheckPermission("config_add")
    @PostMapping("/save")
    @ResponseBody
    public R save(@Validated @RequestBody Config config) {
        configService.save(config);
        return R.ok();
    }

    @SysLog("参数修改")
    @SaCheckPermission("config_edit")
    @PutMapping("/update")
    @ResponseBody
    public R update(@Validated @RequestBody Config config) {
        configService.updateById(config);
        return R.ok();
    }

    @SysLog("参数删除")
    @SaCheckPermission("config_del")
    @DeleteMapping("/remove/{id}")
    @ResponseBody
    public R remove(@PathVariable Integer[] id) {
        try {
            configService.removeByIds(Arrays.asList(id));
            return R.ok();
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
    }
}
