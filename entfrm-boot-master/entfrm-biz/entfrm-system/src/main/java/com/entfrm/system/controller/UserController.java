package com.entfrm.system.controller;

import cn.afterturn.easypoi.excel.ExcelImportUtil;
import cn.afterturn.easypoi.excel.entity.ImportParams;
import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.dev33.satoken.secure.SaSecureUtil;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.base.config.GlobalConfig;
import com.entfrm.base.constant.AppConstants;
import com.entfrm.base.util.UploadUtil;
import com.entfrm.data.annotation.DataFilter;
import com.entfrm.data.util.ExcelUtil;
import com.entfrm.log.annotation.SysLog;
import com.entfrm.security.entity.EntfrmUser;
import com.entfrm.security.util.SecurityUtil;
import com.entfrm.system.entity.Role;
import com.entfrm.system.entity.User;
import com.entfrm.system.entity.UserRole;
import com.entfrm.system.service.RoleService;
import com.entfrm.system.service.UserRoleService;
import com.entfrm.system.service.UserService;
import com.entfrm.system.vo.ResultVo;
import com.entfrm.system.vo.UserVo;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 用户信息
 *
 * @author entfrm
 */
@RestController
@RequestMapping(AppConstants.APP_SYSTEM + "/user")
@AllArgsConstructor
public class UserController {

    private final UserService userService;
    private final UserRoleService userRoleService;
    private final RoleService roleService;
    private final JdbcTemplate jdbcTemplate;

    private QueryWrapper<User> getQueryWrapper(User user) {
        return new QueryWrapper<User>().like(StrUtil.isNotBlank(user.getUserName()), "user_name", user.getUserName()).like(StrUtil.isNotBlank(user.getNickName()), "nick_name", user.getNickName()).eq(StrUtil.isNotBlank(user.getStatus()), "status", user.getStatus())
                .apply(StrUtil.isNotBlank(user.getSqlFilter()), user.getSqlFilter()).eq(ObjectUtil.isNotNull(user.getDeptId()), "dept_id", user.getDeptId());
    }

    @SaCheckPermission("user_view")
    @GetMapping("/list")
    @DataFilter
    public R list(Page page, User user) {
        IPage<User> userIPage = userService.page(page, getQueryWrapper(user));
        return R.ok(userIPage.getRecords(), userIPage.getTotal());
    }

    @SaCheckPermission("user_view")
    @GetMapping("/userList")
    public R userList(User user) {
        List<UserVo> userList = userService.list(getQueryWrapper(user)).stream().map(userInfo -> {
            UserVo userVo = new UserVo();
            userVo.setId(userInfo.getId());
            userVo.setNickName(userInfo.getNickName());
            return userVo;
        }).collect(Collectors.toList());
        return R.ok(userList);
    }

    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        User user = userService.getById(id);
        List<Integer> roles = new ArrayList<>();
        List<Role> roleList = roleService.list();
        if (user != null) {
            roles = userRoleService.list(new QueryWrapper<UserRole>().eq("user_id", user.getId()))
                    .stream().map(userRole -> userRole.getRoleId()).collect(Collectors.toList());

            user.setRoles(ArrayUtil.toArray(roles, Integer.class));
        }
        return R.ok(ResultVo.builder().result(user).extend(roleList).build());
    }

    @SysLog("用户新增")
    @SaCheckPermission("user_add")
    @PostMapping("/save")
    public R save(@RequestBody User user) {
        if (!StrUtil.isEmptyIfStr(user.getId()) && User.isAdmin(user.getId())) {
            return R.error("不允许修改超级管理员");
        }
        user.setPassword(SaSecureUtil.md5(user.getPassword()));
        userService.saveUser(user);
        return R.ok();
    }

    @SysLog("用户修改")
    @SaCheckPermission("user_edit")
    @PutMapping("/update")
    public R update(@RequestBody User user) {
        userService.saveUser(user);
        return R.ok();
    }

    @SysLog("用户删除")
    @SaCheckPermission("user_del")
    @DeleteMapping("/remove/{id}")
    public R remove(@PathVariable Integer[] id) {
        if (ArrayUtil.contains(id, 1)) {
            return R.error("不允许删除超级管理员");
        }
        userService.removeByIds(Arrays.asList(id));
        return R.ok();
    }

    @GetMapping("/profile")
    public R profile() {
        EntfrmUser entfrmUser = SecurityUtil.getUser();
        if (entfrmUser != null) {
            User user = userService.getById(entfrmUser.getId() + "");
            if (user != null) {
                String roleNames = SecurityUtil.getRoleList().stream().map(roleId -> roleService.getById(roleId + "").getName())
                        .collect(Collectors.joining(","));
                user.setRoleNames(roleNames);
                user.setPassword(null);
            }
            return R.ok(user);
        } else {
            return R.error("登录信息已过期，请重新登录");
        }
    }

    @SysLog("用户信息修改")
    @SaCheckPermission("user_edit")
    @PutMapping("/updateProfile")
    public R updateProfile(@RequestBody User user) {
        userService.update(new UpdateWrapper<User>().eq("id", user.getId()).set("nick_name", user.getNickName()).set(StrUtil.isNotBlank(user.getPhone()), "phone", user.getPhone()).set("email", user.getEmail()).set("sex", user.getSex()));
        return R.ok();
    }

    @SysLog("用户头像修改")
    @SaCheckPermission("user_edit")
    @PutMapping("/updateAvatar")
    public R updateAvatar(@RequestParam("avatarfile") MultipartFile file, HttpServletRequest request) {
        String avatar = "/profile/avatar/" + UploadUtil.fileUp(file, GlobalConfig.getAvatarPath(), "avatar" + new Date().getTime());
        userService.update(new UpdateWrapper<User>().eq("id", SecurityUtil.getUser().getId()).set("avatar", avatar));
        return R.ok(avatar);
    }

    @SysLog("用户密码修改")
    @SaCheckPermission("user_edit")
    @PutMapping("/updatePwd")
    public R updatePwd(User user) {
        User user1 = userService.getById(SecurityUtil.getUser().getId());
        if (user1 != null && StrUtil.equals(SaSecureUtil.md5(user.getPassword()), user1.getPassword())) {
            userService.update(new UpdateWrapper<User>().eq("id", user1.getId()).set("password", SaSecureUtil.md5(user.getNewPassword())));
            return R.ok();
        } else {
            return R.error("原密码有误，请重试");
        }
    }

    @SysLog("用户密码重置")
    @SaCheckPermission("user_reset")
    @PutMapping("/resetPwd")
    public R resetPwd(@RequestBody User user) {
        userService.update(new UpdateWrapper<User>().eq("id", user.getId()).set("password", SaSecureUtil.md5(user.getPassword())));
        return R.ok();
    }

    @SysLog("用户状态更改")
    @SaCheckPermission("user_edit")
    @PutMapping("/changeStatus")
    public R changeStatus(@RequestBody User user) {
        if (User.isAdmin(user.getId())) {
            return R.error("不允许修改超级管理员用户");
        }
        userService.update(new UpdateWrapper<User>().eq("id", user.getId()).set("status", user.getStatus()));
        return R.ok();
    }

    @SneakyThrows
    @SysLog("用户数据导出")
    @SaCheckPermission("user_export")
    @GetMapping("/exportUser")
    public void exportUser(User user, ModelMap map, HttpServletRequest request, HttpServletResponse response) {
        List<User> list = userService.list(getQueryWrapper(user));
        ExcelUtil.exportExcel("用户信息", list, User.class, map, request, response);
    }

    @SneakyThrows
    @SysLog("用户数据导入")
    @SaCheckPermission("user_import")
    @PostMapping("/importUser")
    public R importUser(MultipartFile file, boolean updateSupport) {
        ImportParams params = new ImportParams();
        params.setHeadRows(2);
        List<User> userList = ExcelImportUtil.importExcel(file.getInputStream(), User.class, params);
        String message = userService.importUser(userList, updateSupport);
        return R.ok(message);
    }

    @GetMapping("/importTemplate")
    public void importTemplate(ModelMap map, HttpServletRequest request, HttpServletResponse response) {
        List<User> list = new ArrayList<User>();
        ExcelUtil.exportTemplate("用户信息", list, User.class, map, request, response);
    }
}
