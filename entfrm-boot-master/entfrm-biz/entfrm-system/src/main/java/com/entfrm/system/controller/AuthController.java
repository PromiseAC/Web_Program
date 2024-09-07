package com.entfrm.system.controller;

import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.LineCaptcha;
import cn.hutool.crypto.SecureUtil;
import com.entfrm.base.api.R;
import com.entfrm.base.config.GlobalConfig;
import com.entfrm.base.constant.AppConstants;
import com.entfrm.base.constant.CommonConstants;
import com.entfrm.log.annotation.SysLog;
import com.entfrm.log.enums.LogTypeEnum;
import com.entfrm.security.util.SecurityUtil;
import com.entfrm.system.dto.LoginDto;
import com.entfrm.system.entity.Menu;
import com.entfrm.system.service.MenuService;
import com.entfrm.system.service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * @author entfrm
 * @date 2021-12-30
 * @description 登录
 */
@RestController
@AllArgsConstructor
@RequestMapping(AppConstants.APP_SYSTEM)
public class AuthController {

    private final UserService userService;
    private final MenuService menuService;
    private final RedisTemplate redisTemplate;

    /**
     * 宽
     */
    private final Integer WIDTH = 120;
    /**
     * 高
     */
    private final Integer HEIGHT = 40;
    /**
     * 编码长度
     */
    private final Integer CODE_COUNT = 4;
    /**
     * 干扰线数
     */
    private final Integer LINE_COUNT = 20;

    /**
     * 验证码
     *
     * @param key
     */
    @GetMapping(value = "/captcha/{key}")
    public R randomImage(@PathVariable String key) {
        LineCaptcha lineCaptcha = CaptchaUtil.createLineCaptcha(WIDTH, HEIGHT, CODE_COUNT, LINE_COUNT);
        String code = lineCaptcha.getCode();
        String realKey = SecureUtil.md5(code + key);
        if (GlobalConfig.isRedisSwitch()) {
            redisTemplate.opsForValue().set(CommonConstants.CAPTCHA_PREFIX + realKey, code, 60, TimeUnit.SECONDS);
        }
        Map<String, String> res = new HashMap<>(2);
        res.put("realKey", realKey);
        res.put("img", lineCaptcha.getImageBase64());
        return R.ok(res);
    }

    /**
     * 用户登录
     *
     * @return token
     */
    @SysLog(value = "用户登录", type = LogTypeEnum.LOGIN)
    @PostMapping("/login")
    public R login(@RequestBody LoginDto loginDto) {
        String token = userService.login(loginDto);
        return R.ok(token);
    }

    /**
     * 获取当前用户全部信息
     *
     * @return 用户信息
     */
    @GetMapping("/info")
    public R info() {
        return R.ok(SecurityUtil.getUser());
    }

    /**
     * 获取当前用户菜单信息
     *
     * @return 菜单信息
     */
    @GetMapping("/menus")
    public R menus() {
        Set<Menu> menuSet = new HashSet<>();
        SecurityUtil.getRoleList().forEach(roleId -> menuSet.addAll(menuService.selectMenuListByRoleId(roleId)));
        List<Menu> menuList = menuSet.stream().sorted(Comparator.comparingInt(Menu::getSort)).collect(Collectors.toList());
        return R.ok(menuService.buildMenus(menuService.buildTree(menuList, 0)));
    }

    /**
     * 退出登录
     */
    @GetMapping("/logout")
    public R logout() {
        StpUtil.logout();
        return R.ok();
    }
}

