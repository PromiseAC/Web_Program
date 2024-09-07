package com.entfrm.log.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 日志类型
 */
@Getter
@AllArgsConstructor
public enum LogTypeEnum {
    LOGIN (0, "登录日志"),
    OPERATE (1, "操作日志");

    /**
     *  类型值
     */
    private Integer value;

    /**
     * 类型标签
     */
    private String label;

}
