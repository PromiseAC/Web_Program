package com.entfrm.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.base.constant.AppConstants;
import com.entfrm.data.util.ExcelUtil;
import com.entfrm.log.annotation.SysLog;
import com.entfrm.system.entity.OperLog;
import com.entfrm.system.service.OperLogService;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;

/**
 * 系统操作记录
 *
 * @author entfrm
 */
@RestController
@AllArgsConstructor
@RequestMapping(AppConstants.APP_MONITOR + "/operLog")
public class OperLogController {

    private final OperLogService operLogService;

    private QueryWrapper<OperLog> getQueryWrapper(OperLog operLog) {
        return new QueryWrapper<OperLog>().like(StrUtil.isNotBlank(operLog.getOperName()), "oper_name", operLog.getOperName()).like(StrUtil.isNotBlank(operLog.getTitle()), "title", operLog.getTitle()).eq(!StrUtil.isEmptyIfStr(operLog.getStatus()), "status", operLog.getStatus()).eq(!StrUtil.isEmptyIfStr(operLog.getType()), "type", operLog.getType())
                .between(StrUtil.isNotBlank(operLog.getBeginTime()) && StrUtil.isNotBlank(operLog.getEndTime()), "oper_time", operLog.getBeginTime(), operLog.getEndTime()).orderByDesc("id");
    }

    @SaCheckPermission("operLog_view")
    @GetMapping("/list")
    public R list(Page page, OperLog operLog) {
        IPage<OperLog> operLogPage = operLogService.page(page, getQueryWrapper(operLog));
        return R.ok(operLogPage.getRecords(), operLogPage.getTotal());
    }

    @SysLog("操作日志删除")
    @SaCheckPermission("operLog_del")
    @DeleteMapping("/remove/{id}")
    public R remove(@PathVariable String[] id) {
        try {
            operLogService.removeByIds(Arrays.asList(id));
            return R.ok();
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
    }

    @SysLog("操作日志清空")
    @SaCheckPermission("operLog_del")
    @DeleteMapping("/clean")
    public R clean() {
        operLogService.remove(new QueryWrapper<>());
        return R.ok();
    }

    @SneakyThrows
    @SysLog("操作日志")
    @SaCheckPermission("operLog_export")
    @GetMapping("/export")
    public void export(OperLog operLog, ModelMap map, HttpServletRequest request, HttpServletResponse response) {
        List<OperLog> list = operLogService.list(getQueryWrapper(operLog));
        ExcelUtil.exportExcel("操作日志", list, OperLog.class, map, request, response);
    }
}
