package com.entfrm.data.util;

import cn.afterturn.easypoi.entity.vo.NormalExcelConstants;
import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.ExcelImportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import cn.afterturn.easypoi.excel.entity.ImportParams;
import cn.afterturn.easypoi.excel.entity.enmus.ExcelType;
import cn.afterturn.easypoi.view.PoiBaseView;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.util.List;

/**
 * @author entfrm
 * @date 2022-01-25
 * @description 表格
 */
public class ExcelUtil {

    //导入数据
    public static List<?> importExcel(InputStream inputstream, Class<?> entity) throws Exception{
        ImportParams params = new ImportParams();
        params.setHeadRows(2);
        return ExcelImportUtil.importExcel(inputstream, entity, params);
    }

    //导出模板
    public static void exportTemplate(String title, List<?> list, Class<?> entity, ModelMap map, HttpServletRequest request, HttpServletResponse response){
        ExportParams params = new ExportParams(title + "模板", title, ExcelType.XSSF);
        params.setFreezeCol(2);
        map.put(NormalExcelConstants.DATA_LIST, list);
        map.put(NormalExcelConstants.CLASS, entity);
        map.put(NormalExcelConstants.PARAMS, params);
        PoiBaseView.render(map, request, response, NormalExcelConstants.EASYPOI_EXCEL_VIEW);
    }

    //导出数据
    public static void exportExcel(String title, List<?> list, Class<?> entity, ModelMap map, HttpServletRequest request, HttpServletResponse response){
        ExportParams params = new ExportParams(title + "数据", title, ExcelType.XSSF);
        params.setFreezeCol(2);
        map.put(NormalExcelConstants.DATA_LIST, list);
        map.put(NormalExcelConstants.CLASS, entity);
        map.put(NormalExcelConstants.PARAMS, params);
        PoiBaseView.render(map, request, response, NormalExcelConstants.EASYPOI_EXCEL_VIEW);
    }

}
