package com.entfrm.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.base.constant.AppConstants;
import com.entfrm.data.util.ExcelUtil;
import com.entfrm.log.annotation.SysLog;
import com.entfrm.security.util.SecurityUtil;
import com.entfrm.system.entity.Application;
import com.entfrm.system.service.ApplicationService;
import lombok.AllArgsConstructor;
import org.springframework.ui.ModelMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;

/**
 * @author entfrm
 * @date 2020-04-23 18:15:10
 * @description 应用Controller
 */
@RestController
@AllArgsConstructor
@RequestMapping(AppConstants.APP_SYSTEM + "/application")
public class ApplicationController {

    private final ApplicationService applicationService;

    private QueryWrapper<Application> getQueryWrapper(Application application) {
        return new QueryWrapper<Application>()
                .like(StrUtil.isNotBlank(application.getName()), "name", application.getName())
                .eq(StrUtil.isNotBlank(application.getType()), "type", application.getType())
                .eq(StrUtil.isNotBlank(application.getStatus()), "status", application.getStatus())
                .orderByDesc("create_time");
    }

    @SaCheckPermission("application_view")
    @GetMapping("/list")
    public R list(Page page, Application application) {
        IPage<Application> applicationPage = applicationService.page(page, getQueryWrapper(application));
        return R.ok(applicationPage.getRecords(), applicationPage.getTotal());
    }

    @GetMapping("/tree")
    public R tree(Application application) {
        List<Application> applicationList = applicationService.list(getQueryWrapper(application));
        return R.ok(applicationList);
    }

    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(applicationService.getById(id));
    }

    @SysLog("应用新增")
    @SaCheckPermission("application_add")
    @PostMapping("/save")
    public R save(@Validated @RequestBody Application application) {
        application.setDeptId(SecurityUtil.getUser().getDeptId());
        applicationService.save(application);
        return R.ok();
    }

    @SysLog("应用修改")
    @SaCheckPermission("application_edit")
    @PutMapping("/update")
    public R update(@Validated @RequestBody Application application) {
        application.setDeptId(SecurityUtil.getUser().getDeptId());
        applicationService.updateById(application);
        return R.ok();
    }


    @SysLog("应用删除")
    @SaCheckPermission("application_del")
    @DeleteMapping("/remove/{id}")
    public R remove(@PathVariable("id") Integer[] id) {
        if (ArrayUtil.contains(id, 1)) {
            return R.error("该应用不可删除");
        }
        return R.ok(applicationService.removeByIds(Arrays.asList(id)));
    }


    @SaCheckPermission("application_export")
    @GetMapping("/export")
    public void export(Application application, ModelMap map, HttpServletRequest request, HttpServletResponse response) {
        List<Application> list = applicationService.list(getQueryWrapper(application));
        ExcelUtil.exportExcel("应用信息", list, Application.class, map, request, response);
    }
}
