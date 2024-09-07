package com.entfrm.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.base.constant.AppConstants;
import com.entfrm.log.annotation.SysLog;
import com.entfrm.system.entity.Shortcut;
import com.entfrm.system.service.ShortcutService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;


/**
 * @author entfrm
 * @date 2019-08-25 22:56:58
 * @description 快捷方式Controller
 */
@RestController
@AllArgsConstructor
@RequestMapping(AppConstants.APP_SYSTEM + "/shortcut")
public class ShortcutController {

    private final ShortcutService shortcutService;

    private QueryWrapper<Shortcut> getQueryWrapper(Shortcut shortcut) {
        return new QueryWrapper<Shortcut>().like(StrUtil.isNotBlank(shortcut.getName()), "name", shortcut.getName()).eq(StrUtil.isNotBlank(shortcut.getRegion()), "region", shortcut.getRegion())
                .orderByAsc("sort");
    }

    @SaCheckPermission("shortcut_view")
    @GetMapping("/list")
    public R list(Page page, Shortcut shortcut) {
        IPage<Shortcut> shortcutPage = shortcutService.page(page, getQueryWrapper(shortcut));
        return R.ok(shortcutPage.getRecords(), shortcutPage.getTotal());
    }

    @SaCheckPermission("shortcut_view")
    @GetMapping("/shortcutList")
    public R shortcutList(Shortcut shortcut) {
        List<Shortcut> shortcutList = shortcutService.list(getQueryWrapper(shortcut));
        return R.ok(shortcutList);
    }

    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(shortcutService.getById(id));
    }

    @SysLog("快捷方式新增")
    @SaCheckPermission("shortcut_add")
    @PostMapping("/save")
    public R save(@RequestBody Shortcut shortcut) {
        shortcutService.saveOrUpdate(shortcut);
        return R.ok();
    }

    @SysLog("快捷方式修改")
    @SaCheckPermission("shortcut_edit")
    @PutMapping("/update")
    public R update(@RequestBody Shortcut shortcut) {
        shortcutService.updateById(shortcut);
        return R.ok();
    }

    @SysLog("快捷方式删除")
    @SaCheckPermission("shortcut_del")
    @DeleteMapping("/remove/{id}")
    public R remove(@PathVariable("id") Integer[] id) {
        return R.ok(shortcutService.removeByIds(Arrays.asList(id)));
    }
}
