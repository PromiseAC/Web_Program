package com.entfrm.toolkit.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.base.constant.AppConstants;
import com.entfrm.base.constant.CommonConstants;
import com.entfrm.base.util.StrUtil;
import com.entfrm.data.util.ExcelUtil;
import com.entfrm.log.annotation.SysLog;
import com.entfrm.toolkit.dto.FormDto;
import com.entfrm.toolkit.entity.Column;
import com.entfrm.toolkit.entity.Form;
import com.entfrm.toolkit.entity.Table;
import com.entfrm.toolkit.service.ColumnService;
import com.entfrm.toolkit.service.FormService;
import com.entfrm.toolkit.service.TableService;
import com.entfrm.toolkit.util.BuilderUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;
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
 * @date 2021-03-11 21:57:03
 * @description 表单Controller
 */
@Api("表单管理")
@RestController
@AllArgsConstructor
@RequestMapping(AppConstants.APP_TOOLKIT + "/form")
public class FormController {

    private final JdbcTemplate jdbcTemplate;
    private final FormService formService;
    private final TableService tableService;
    private final ColumnService columnService;

    private QueryWrapper<Form> getQueryWrapper(Form form) {
        return new QueryWrapper<Form>()
                .like(StrUtil.isNotBlank(form.getName()), "name", form.getName())
                .eq(StrUtil.isNotBlank(form.getType()), "type", form.getType())
                .like(StrUtil.isNotBlank(form.getTableName()), "table_name", form.getTableName())
                .orderByDesc("id");
    }

    @ApiOperation("表单列表")
    @SaCheckPermission("form_view")
    @GetMapping("/list")
    public R list(Page page, Form form) {
        IPage<Form> formPage = formService.page(page, getQueryWrapper(form));
        return R.ok(formPage.getRecords(), formPage.getTotal());
    }

    @ApiOperation("表单查询")
    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(formService.getById(id));
    }

    @SysLog("表单新增")
    @ApiOperation("表单新增")
    @SaCheckPermission("form_add")
    @PostMapping("/save")
    @Transactional
    public R save(@Validated @RequestBody Form form) {
        formService.save(form);
        return R.ok();
    }

    @SysLog("表单修改")
    @ApiOperation("表单修改")
    @SaCheckPermission("form_edit")
    @PutMapping("/update")
    public R update(@Validated @RequestBody Form form) {
        if ("0".equals(form.getAutoCreate())) {
            Table table = tableService.getOne(new QueryWrapper<Table>().eq("table_name", CommonConstants.PREFIX + form.getTableName()));
            if(table == null){
                table = BuilderUtil.createForm(form);
                tableService.save(table);
                if (table.getColumns() != null && table.getColumns().size() > 0) {
                    for (Column column : table.getColumns()) {
                        column.setTableId(table.getId());
                        columnService.save(column);
                    }
                }
                //创建SQL脚本
                jdbcTemplate.execute(BuilderUtil.createTable(table));
            }else {
                //todo 更新表结构
            }
        }
        formService.updateById(form);
        return R.ok();
    }

    @SysLog("表单删除")
    @ApiOperation("表单删除")
    @SaCheckPermission("form_del")
    @DeleteMapping("/remove/{id}")
    public R remove(@PathVariable("id") Integer[] id) {
        return R.ok(formService.removeByIds(Arrays.asList(id)));
    }


    @SaCheckPermission("form_export")
    @GetMapping("/export")
    public void export(Form form, ModelMap map, HttpServletRequest request, HttpServletResponse response) {
        List<Form> list = formService.list(getQueryWrapper(form));
        ExcelUtil.exportExcel("表单信息", list, Form.class, map, request, response);
    }

    @ApiOperation("动态表单列表")
    @GetMapping("/dynamicFormList")
    public R dynamicFormList(Page page, Form form, @RequestParam("params") String params) {
        IPage<Map> formPage = formService.mapFormPage(page, form, params);
        return R.ok(formPage.getRecords(), formPage.getTotal());
    }

    @ApiOperation("动态表单查询")
    @GetMapping("/dynamicForm")
    public R dynamicFormById(String tableName, Integer id) {
        Form form = formService.getOne(new QueryWrapper<Form>().eq("table_name", tableName));
        return R.ok(formService.queryData(tableName, id), form.getData());
    }

    @PostMapping("dynamicFormSave")
    public R dynamicFormSave(@RequestBody FormDto formDto) throws Exception{
        Form form = formService.getById(formDto.getFormId());
        List<Column> columns = BuilderUtil.createColumns(form.getData());
        formService.saveData(form, columns, formDto.getData());
        return R.ok("保存数据成功");
    }

    @ApiOperation("动态表单删除")
    @DeleteMapping("/dynamicFormRemove")
    public R dynamicFormRemove(String tableName, Integer[] ids) {
        formService.removeData(tableName, ids);
        return R.ok();
    }

    @GetMapping("/column/{tableName}")
    public R column(@PathVariable String tableName) {
        Table table = tableService.getOne(new QueryWrapper<Table>().eq("table_name", CommonConstants.PREFIX + tableName));
        List<Column> columnList = columnService.list(new QueryWrapper<Column>().eq("table_id", table.getId()));
        return R.ok(columnList);
    }

}
