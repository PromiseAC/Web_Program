package com.entfrm.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.base.constant.AppConstants;
import com.entfrm.system.entity.Dict;
import com.entfrm.system.service.DictService;
import com.entfrm.log.annotation.SysLog;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 数据字典信息
 *
 * @author entfrm
 */
@RestController
@AllArgsConstructor
@RequestMapping(AppConstants.APP_SYSTEM + "/dict")
public class DictController {

    private final DictService dictService;

    private QueryWrapper<Dict> getQueryWrapper(Dict dict) {
        return new QueryWrapper<Dict>().like(StrUtil.isNotBlank(dict.getName()), "name", dict.getName()).orderByDesc("id")
                .eq(StrUtil.isNotBlank(dict.getType()), "type", dict.getType()).eq(StrUtil.isNotBlank(dict.getStatus()), "status", dict.getStatus());
    }

    @SaCheckPermission("dict_view")
    @GetMapping("/list")
    public R list(Page page, Dict dict) {
        IPage<Dict> dictPage = dictService.page(page, getQueryWrapper(dict));
        return R.ok(dictPage.getRecords(), dictPage.getTotal());
    }

    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(dictService.getById(id));
    }

    @SysLog("字典新增")
    @SaCheckPermission("dict_add")
    @PostMapping("/save")
    @ResponseBody
    public R save(@RequestBody Dict dict) {
        dictService.save(dict);
        return R.ok();
    }

    @SysLog("字典修改")
    @SaCheckPermission("dict_edit")
    @PutMapping("/update")
    @ResponseBody
    public R update(@RequestBody Dict dict) {
        dictService.updateById(dict);
        return R.ok();
    }

    @SysLog("字典删除")
    @SaCheckPermission("dict_del")
    @DeleteMapping("/remove/{id}")
    @ResponseBody
    public R remove(@PathVariable Integer[] id) {
        try {
            dictService.removeByIds(Arrays.asList(id));
            return R.ok();
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
    }

    @SysLog("字典状态更改")
    @SaCheckPermission("dict_edit")
    @GetMapping("/changeStatus")
    @ResponseBody
    public R changeStatus(Dict dict) {
        dictService.updateById(dict);
        return R.ok();
    }

    /**
     * 获取所有字典列表
     */
    @GetMapping("/dictList")
    public R dictList() {
        List<Dict> dictList = dictService.list();
        return R.ok(dictList);
    }
}
