package com.entfrm.log.annotation;

import com.entfrm.log.enums.LogTypeEnum;

import java.lang.annotation.*;

/**
 * @author entfrm
 * @date 2019/11/28
 * 系统日志注解
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface SysLog {
    /**
     * 描述
     *
     * @return {String}
     */
    String value();
    /**
     * 日志类型
     *
     * @return {String}
     */
    LogTypeEnum type() default LogTypeEnum.OPERATE;
}
