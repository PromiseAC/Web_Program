package com.entfrm.data.aspect;

import com.entfrm.base.exception.BaseException;
import com.entfrm.data.annotation.DataFilter;
import com.entfrm.data.entity.BaseEntity;
import com.entfrm.data.util.DataAuthUtil;
import lombok.AllArgsConstructor;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

/**
 * 数据过滤，切面处理类
 *
 * @author yong
 * @since 2017-09-17
 */
@Aspect
@Component
@AllArgsConstructor
public class DataFilterAspect {

    @Pointcut("@annotation(com.entfrm.data.annotation.DataFilter)")
    public void dataFilterCut() {

    }

    @Before("dataFilterCut()")
    public void dataFilter(JoinPoint point) throws Throwable {
        Object params = null;
        if(point.getArgs().length > 1){
            params = point.getArgs()[1];
        }else {
            params = point.getArgs()[0];
        }
        if (params != null && params instanceof BaseEntity) {

            BaseEntity baseEntity = (BaseEntity) params;

            baseEntity.setSqlFilter(getSQLFilter(point));

            return;
        }

        throw new BaseException("数据权限接口参数有误，请联系管理员");
    }

    /**
     * 获取数据过滤的SQL
     */
    private String getSQLFilter(JoinPoint point) {
        MethodSignature signature = (MethodSignature) point.getSignature();
        DataFilter dataFilter = signature.getMethod().getAnnotation(DataFilter.class);
        //获取表的别名
        String tableAlias = dataFilter.tableAlias();

        return DataAuthUtil.getSQLFilter(tableAlias);
    }
}
