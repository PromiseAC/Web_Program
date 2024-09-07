package com.entfrm.system.dto;

import lombok.Data;

/**
 * @author entfrm
 * @date 2022-01-11
 * @description 登录信息
 */
@Data
public class LoginDto {
    /**
     * 用户名
     */
    private String userName;

    /**
     * 用户密码
     */
    private String password;

    /**
     * 验证码
     */
    private String code;

    private String realKey;
}
