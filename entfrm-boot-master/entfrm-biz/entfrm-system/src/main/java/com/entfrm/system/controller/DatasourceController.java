package com.entfrm.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.extra.spring.SpringUtil;
import com.baomidou.dynamic.datasource.DynamicRoutingDataSource;
import com.baomidou.dynamic.datasource.creator.DataSourceCreator;
import com.baomidou.dynamic.datasource.spring.boot.autoconfigure.DataSourceProperty;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.base.constant.AppConstants;
import com.entfrm.system.entity.Datasource;
import com.entfrm.system.service.DatasourceService;
import com.entfrm.log.annotation.SysLog;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import javax.sql.DataSource;
import java.util.Arrays;
import java.util.List;


/**
 * @author entfrm
 * @date 2019-10-11 09:13:04
 * @description 数据库Controller
 */
@RestController
@AllArgsConstructor
@RequestMapping(AppConstants.APP_SYSTEM + "/datasource")
public class DatasourceController {

    private final DatasourceService datasourceService;
    private final DataSourceCreator druidDataSourceCreator;

    private QueryWrapper<Datasource> getQueryWrapper(Datasource datasource) {
        return new QueryWrapper<Datasource>().orderByDesc("create_time");
    }

    @SaCheckPermission("datasource_view")
    @GetMapping("/list")
    @ResponseBody
    public R list(Page page, Datasource datasource) {
        IPage<Datasource> datasourcePage = datasourceService.page(page, getQueryWrapper(datasource));
        return R.ok(datasourcePage.getRecords(), datasourcePage.getTotal());
    }

    @SaCheckPermission("datasource_view")
    @GetMapping("/datasourceList")
    @ResponseBody
    public R datasourceList(Datasource datasource) {
        List<Datasource> datasourceList = datasourceService.list();
        return R.ok(datasourceList);
    }

    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(datasourceService.getById(id));
    }

    @SysLog("数据库新增")
    @SaCheckPermission("datasource_add")
    @PostMapping("/save")
    @ResponseBody
    public R save(@RequestBody Datasource datasource) {
        datasource.setAlias(datasource.getName());
        datasourceService.save(datasource);
        // 添加动态数据源
        addDynamicDataSource(datasource);
        return R.ok();
    }

    @SysLog("数据库修改")
    @SaCheckPermission("datasource_edit")
    @PutMapping("/update")
    @ResponseBody
    public R update(@RequestBody Datasource datasource) {
        datasource.setAlias(datasource.getName());
        datasourceService.updateById(datasource);
        // 先移除
        DynamicRoutingDataSource dynamicRoutingDataSource = SpringUtil.getBean(DynamicRoutingDataSource.class);
        dynamicRoutingDataSource.removeDataSource(datasource.getName());

        // 再添加
        addDynamicDataSource(datasource);
        return R.ok();
    }

    @SysLog("数据库删除")
    @SaCheckPermission("datasource_del")
    @DeleteMapping("/remove/{id}")
    @ResponseBody
    public R remove(@PathVariable("id") Integer[] id) {
        //删除缓存中的数据源
        for(Integer did : id){
            Datasource datasource = datasourceService.getById(did);
            if(datasource != null){
                DynamicRoutingDataSource dynamicRoutingDataSource = SpringUtil.getBean(DynamicRoutingDataSource.class);
                dynamicRoutingDataSource.removeDataSource(datasource.getName());
            }
        }
        datasourceService.removeByIds(Arrays.asList(id));
        return R.ok();
    }

    //新增数据源
    private void addDynamicDataSource(Datasource datasource) {
        DataSourceProperty dataSourceProperty = new DataSourceProperty();
        dataSourceProperty.setPoolName(datasource.getName());
        dataSourceProperty.setUrl(datasource.getUrl());
        dataSourceProperty.setUsername(datasource.getUsername());
        dataSourceProperty.setPassword(datasource.getPassword());
        DataSource dataSource = druidDataSourceCreator.createDataSource(dataSourceProperty);

        DynamicRoutingDataSource dynamicRoutingDataSource = SpringUtil.getBean(DynamicRoutingDataSource.class);
        dynamicRoutingDataSource.addDataSource(dataSourceProperty.getPoolName(), dataSource);
    }
}
