package com.entfrm.base.constant;

/**
 * @author yong
 * @date 2020/2/1
 */
public interface CommonConstants {
    /**
     * 验证码前缀
     */
    String CAPTCHA_PREFIX = "Captcha:";
    /**
     * 数据名称
     */
    String DB_NAME = "entfrm";

    /**
     * 前缀
     */
    String PREFIX = "entfrm_";

    /**
     * 前缀
     */
    String SQLPREFIX = "form_";

    /**
     * UTF-8 字符集
     */
    String UTF8 = "UTF-8";

    /**
     * 成功标记
     */
    Integer SUCCESS = 0;
    /**
     * 失败标记
     */
    Integer FAIL = 1;

    /**
     * 角色前缀
     */
    String ROLE = "ROLE_";

    /**
     * 资源映射路径 前缀
     */
    String RESOURCE_PREFIX = "/profile";

    /**
     * 作者
     */
    String AUTHOR = "by entfrm";

    /**
     * 当前页
     */
    String CURRENT = "current";
    /**
     * 每页大小
     */
    String SIZE = "size";
    /**
     * 系统模块前缀
     */
    String SYSTEM = "/system";

    /**
     * http请求
     */
    String HTTP = "http://";
    /**
     * https请求
     */
    String HTTPS = "https://";
    /**
     * RMI 远程方法调用
     */
    String LOOKUP_RMI = "rmi:";
    /**
     * LDAP 远程方法调用
     */
    String LOOKUP_LDAP = "ldap:";
    /**
     * LDAPS 远程方法调用
     */
    String LOOKUP_LDAPS = "ldaps:";
    /**
     * 定时任务违规的字符
     */
    String[] JOB_ERROR_STR = { "java.net.URL", "javax.naming.InitialContext", "org.yaml.snakeyaml", "org.springframework", "org.apache" };
    /**
     * 定时任务白名单配置（仅允许访问的包名，如其他需要可以自行添加）
     */
    String[] JOB_WHITELIST_STR = { "com.entfrm" };
}
