package com.entfrm.security.util;

import cn.dev33.satoken.stp.StpUtil;
import com.entfrm.base.constant.CommonConstants;
import com.entfrm.base.util.StrUtil;
import com.entfrm.security.entity.EntfrmUser;
import lombok.experimental.UtilityClass;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * @author entfrm
 * @date 2022-01-09
 * @description 安全工具类
 */
@UtilityClass
public class SecurityUtil {

    private String USER_KEY = "entfrm";

    public void setUser(String userName, EntfrmUser entfrmUser){
        StpUtil.login(userName);
        StpUtil.getTokenSession().set(USER_KEY, entfrmUser);
    }

    public EntfrmUser getUser(){
        return (EntfrmUser) StpUtil.getTokenSession().get(USER_KEY);
    }

    public String getUserName() {
        return getUser().getUserName();
    }

    public Integer getDeptId() {
        return getUser().getDeptId();
    }

    public Set<String> getRoles() {
        return getUser().getRoles();
    }

    public List<Integer> getRoleList() {
        List<Integer> roleIds = new ArrayList<>();
        getRoles().stream()
                .filter(roleId -> StrUtil.startWith(roleId, CommonConstants.ROLE))
                .forEach(roleId -> {
                    String id = StrUtil.removePrefix(roleId, CommonConstants.ROLE);
                    roleIds.add(Integer.parseInt(id));
                });
        return roleIds;
    }

    public Set<String> getPermissions() {
        return getUser().getPermissions();
    }
}
