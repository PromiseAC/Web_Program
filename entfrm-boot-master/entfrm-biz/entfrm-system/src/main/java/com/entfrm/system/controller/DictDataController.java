package com.entfrm.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.base.constant.AppConstants;
import com.entfrm.system.entity.DictData;
import com.entfrm.system.service.DictDataService;
import com.entfrm.system.service.DictService;
import com.entfrm.log.annotation.SysLog;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

/**
 * 数据字典信息
 *
 * @author entfrm
 */
@RestController
@AllArgsConstructor
@RequestMapping(AppConstants.APP_SYSTEM + "/dictData")
public class DictDataController {

    private final DictDataService dictDataService;
    private final DictService dictService;

    private QueryWrapper<DictData> getQueryWrapper(DictData dictData) {
        return new QueryWrapper<DictData>().like(StrUtil.isNotBlank(dictData.getLabel()), "label", dictData.getLabel())
                .eq(StrUtil.isNotBlank(dictData.getDictType()), "dict_type", dictData.getDictType()).orderByDesc("id");
    }

    @SaCheckPermission("dictData_view")
    @GetMapping("/list")
    @ResponseBody
    public R list(Page page, DictData dictData) {
        IPage<DictData> dictPage = dictDataService.page(page, getQueryWrapper(dictData));
        return R.ok(dictPage.getRecords(), dictPage.getTotal());
    }

    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(dictDataService.getById(id));
    }

    @GetMapping("/dictType/{dictType}")
    @ResponseBody
    public R dictType(@PathVariable String dictType) {
        return R.ok(dictDataService.getDictDataList(dictType));
    }

    @SysLog("字典数据新增")
    @SaCheckPermission("dictData_add")
    @PostMapping("/save")
    @ResponseBody
    public R save(@RequestBody DictData dictData) {
        dictDataService.save(dictData);
        return R.ok();
    }

    @SysLog("字典数据修改")
    @SaCheckPermission("dictData_edit")
    @PutMapping("/update")
    public R update(@RequestBody DictData dictData) {
        dictDataService.updateById(dictData);
        return R.ok();
    }

    @SysLog("字典数据删除")
    @SaCheckPermission("dictData_del")
    @DeleteMapping("/remove/{id}")
    @ResponseBody
    public R remove(@PathVariable Integer[] id) {
        dictDataService.removeByIds(Arrays.asList(id));
        return R.ok();
    }

    @GetMapping("/getDictData")
    @ResponseBody
    public R getDictData(String dictType, String value) {
        DictData dictData = dictDataService.getOne(new QueryWrapper<DictData>().eq("dict_type", dictType).eq("value", value));
        if(dictData != null){
            return R.ok(dictData.getLabel());
        }else {
            return R.error("数据不存在");
        }
    }
}
