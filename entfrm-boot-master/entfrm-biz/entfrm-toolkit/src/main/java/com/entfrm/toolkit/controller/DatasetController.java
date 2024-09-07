package com.entfrm.toolkit.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.constant.AppConstants;
import com.entfrm.data.util.ExcelUtil;
import com.entfrm.toolkit.entity.Dataset;
import com.entfrm.toolkit.service.DatasetService;
import com.entfrm.toolkit.util.BuilderUtil;
import com.entfrm.base.api.R;
import com.entfrm.log.annotation.SysLog;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.ui.ModelMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * @author entfrm
 * @date 2020-06-12 21:56:29
 * @description 数据源Controller
 */
@Api("数据源管理")
@RestController
@AllArgsConstructor
@RequestMapping(AppConstants.APP_TOOLKIT + "/dataset")
public class DatasetController {

    private final JdbcTemplate jdbcTemplate;
    private final DatasetService datasetService;

    private QueryWrapper<Dataset> getQueryWrapper(Dataset dataset) {
        return new QueryWrapper<Dataset>()
                .like(StrUtil.isNotBlank(dataset.getName()), "name", dataset.getName())
                .eq(StrUtil.isNotBlank(dataset.getFtype()), "ftype", dataset.getFtype())
                .orderByDesc("create_time");
    }

    @ApiOperation("数据源列表")
    @SaCheckPermission("dataset_view")
    @GetMapping("/list")
    public R list(Page page, Dataset dataset) {
        IPage<Dataset> datasetPage = datasetService.page(page, getQueryWrapper(dataset));
        return R.ok(datasetPage.getRecords(), datasetPage.getTotal());
    }

    /**
     * **
     * 解析sql脚本
     *
     * @param alias
     * @return
     */
    @GetMapping("/analysisScripts")
    public R analysisScripts(@RequestParam String alias, @RequestParam String scripts) {
        String tableName = BuilderUtil.getTableName(scripts);
        if (StrUtil.isNotBlank(tableName)) {
//            DSContextHolder.setDSType(AliasUtil.getDsId(alias));
//
            StringBuilder sql = new StringBuilder();
//            if (DataTypeEnum.MYSQL.getType().equals(AliasUtil.getDsType(alias))) {
//                sql.append("select COLUMN_NAME columnName, DATA_TYPE dataType from information_schema.columns where table_schema='" + AliasUtil.getDsName(alias) + "' and table_name='" + tableName + "'");
//            }

            List<Map<String, Object>> list = jdbcTemplate.queryForList(sql.toString());
            list.stream().forEach(map -> {
                map.put("javaField", StrUtil.toCamelCase(map.get("columnName").toString()));
                map.put("isShow", "0");
                map.put("isParam", "0");
            });
            return R.ok(list);
        } else {
            return R.error("请输入正确的SQL脚本");
        }
    }

    /**
     * **
     * 预览数据
     *
     * @param alias
     * @return
     */
    @GetMapping("/previewData")
    public R previewData(@RequestParam String alias, @RequestParam String scripts) {
        //DSContextHolder.setDSType(AliasUtil.getDsId(alias));
        List<Map<String, Object>> list = jdbcTemplate.queryForList(scripts);
        return R.ok(list);
    }

    @ApiOperation("数据源查询")
    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(datasetService.getById(id));
    }

    /**
     * **
     * 数据接口
     *
     * @param ftype
     * @param code
     * @return
     */
    @GetMapping("/api/{ftype}/{code}")
    public R dataApi(@PathVariable String ftype, @PathVariable String code, @RequestParam Map<String, Object> params) {
        Dataset dataset = datasetService.getOne(new QueryWrapper<Dataset>().eq("code", code));
        if (dataset != null) {
            String sql = dataset.getScripts();
            String wStr = "";
            JSONArray array = JSONUtil.parseArray(dataset.getCdata());
            if (array != null && array.size() > 0) {
                for (int i = 0; i < array.size(); i++) {
                    JSONObject jsonObject = array.getJSONObject(i);
                    if ("1".equals(jsonObject.getStr("isParam"))) {
                        Object temp = params.get(jsonObject.getStr("javaField"));
                        if (temp != null) {
                            wStr += jsonObject.getStr("columnName") + " = '" + temp.toString() + "' and ";
                        }
                    }
                }
            }
            if (StrUtil.isNotBlank(wStr)) {
                sql += " " + wStr.substring(0, wStr.length() - 4);
            }
            List<Map<String, Object>> list = jdbcTemplate.queryForList(sql);
            return R.ok(list);
        } else {
            return R.error("数据源不存在");
        }
    }

    @SysLog("数据源新增")
    @ApiOperation("数据源新增")
    @SaCheckPermission("dataset_add")
    @PostMapping("/save")
    public R save(@Validated @RequestBody Dataset dataset) {
        dataset.setCode(IdWorker.get32UUID());
        datasetService.save(dataset);
        return R.ok();
    }

    @SysLog("数据源修改")
    @ApiOperation("数据源修改")
    @SaCheckPermission("dataset_edit")
    @PutMapping("/update")
    public R update(@Validated @RequestBody Dataset dataset) {
        datasetService.updateById(dataset);
        return R.ok();
    }


    @SysLog("数据源删除")
    @ApiOperation("数据源删除")
    @SaCheckPermission("dataset_del")
    @DeleteMapping("/remove/{id}")
    public R remove(@PathVariable("id") Integer[] id) {
        return R.ok(datasetService.removeByIds(Arrays.asList(id)));
    }


    @SaCheckPermission("dataset_export")
    @GetMapping("/export")
    public void export(Dataset dataset, ModelMap map, HttpServletRequest request, HttpServletResponse response) {
        List<Dataset> list = datasetService.list(getQueryWrapper(dataset));
        ExcelUtil.exportExcel("数据源", list, Dataset.class, map, request, response);
    }
}
