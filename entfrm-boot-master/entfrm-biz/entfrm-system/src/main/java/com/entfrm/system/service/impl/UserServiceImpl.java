package com.entfrm.system.service.impl;

import cn.dev33.satoken.secure.SaSecureUtil;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.entfrm.base.constant.CommonConstants;
import com.entfrm.base.constant.SqlConstants;
import com.entfrm.base.exception.BaseException;
import com.entfrm.security.entity.EntfrmUser;
import com.entfrm.security.util.SecurityUtil;
import com.entfrm.system.dto.LoginDto;
import com.entfrm.system.entity.*;
import com.entfrm.system.mapper.UserMapper;
import com.entfrm.system.service.*;
import lombok.AllArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * <p>
 * 用户信息表 服务实现类
 * </p>
 *
 * @author entfrm
 * @since 2019-01-30
 */
@Service
@AllArgsConstructor
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    private final ConfigService configService;
    private final RoleService roleService;
    private final MenuService menuService;
    private final UserRoleService userRoleService;
    private final DeptService deptService;
    private final RedisTemplate redisTemplate;

    @Override
    public String login(LoginDto loginDto) {
        // 验证码校验
        String redisKey = CommonConstants.CAPTCHA_PREFIX + loginDto.getRealKey();
        Object obj = redisTemplate.opsForValue().get(redisKey);
        if (obj == null || (obj != null && !StrUtil.equals(obj.toString().toLowerCase(), loginDto.getCode().toLowerCase()))) {
            throw new BaseException("sys.captcha.incorrect", loginDto.getCode());
        }
        redisTemplate.delete(redisKey);
        // Todo 密码错误尝试
        User user = baseMapper.selectOne(new QueryWrapper<User>().eq("user_name", loginDto.getUserName()));
        if (StrUtil.isEmptyIfStr(user)) {
            throw new BaseException("sys.account.notexists", loginDto.getUserName());
        } else if ("1".equals(user.getStatus())) {
            throw new BaseException("sys.account.locked", loginDto.getUserName());
        }
        //密码校验
        if (!StrUtil.equals(user.getPassword(), SaSecureUtil.md5(loginDto.getPassword()))) {
            throw new BaseException("sys.password.incorrect", loginDto.getUserName());
        }
        EntfrmUser entfrmUser = new EntfrmUser();
        BeanUtils.copyProperties(user, entfrmUser);
        List<Role> roleList = roleService.selectMyRolesByUserId(entfrmUser.getId());
        Set<String> roles = new HashSet<>();
        Set<String> permissions = new HashSet<>();
        roleList.forEach(role -> {
            roles.add(CommonConstants.ROLE + role.getId());
            List<String> perms = menuService.selectPermsByRoleId(role.getId());
            if(perms != null && perms.size() > 0){
                permissions.addAll(perms);
            }
        });
        entfrmUser.setRoles(roles);
        entfrmUser.setPermissions(permissions);
        SecurityUtil.setUser(loginDto.getUserName(), entfrmUser);
        return StpUtil.getTokenValue();
    }

    @Override
    @Transactional
    public int saveUser(User user) {
        if (StrUtil.isEmptyIfStr(user.getId())) {
            // 新增用户信息
            int rows = baseMapper.insert(user);
            // 新增用户与角色管理
            addUserRole(user);
            return rows;
        } else {
            // 删除用户与角色关联
            userRoleService.remove(new QueryWrapper<UserRole>().eq("user_id", user.getId()));
            // 新增用户与角色管理
            addUserRole(user);
            user.setPassword(null);
            return baseMapper.updateById(user);
        }
    }

    /**
     * 新增用户角色信息
     *
     * @param user 用户对象
     */
    public void addUserRole(User user) {
        Integer[] roles = user.getRoles();
        if (roles != null) {
            // 新增用户与角色管理
            for (Integer roleId : roles) {
                UserRole ur = new UserRole();
                ur.setUserId(user.getId());
                ur.setRoleId(roleId);
                userRoleService.save(ur);
            }
        }
    }

    /**
     * 导入用户数据
     *
     * @param userList        用户数据列表
     * @param isUpdateSupport 是否更新支持，如果已存在，则进行更新数据
     * @return 结果
     */
    @Override
    public String importUser(List<User> userList, Boolean isUpdateSupport) {
        if (userList == null || userList.size() == 0) {
            throw new BaseException("导入用户数据不能为空！");
        }
        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();
        String password = configService.getValueByKey("user.initPassword");
        for (User user : userList) {
            try {
                // 验证是否存在这个用户
                User u = baseMapper.selectOne(new QueryWrapper<User>().eq("user_name", user.getUserName()));
                if (u == null) {
                    user.setPassword(SaSecureUtil.md5(password));
                    if (StrUtil.isNotBlank(user.getDeptName())) {
                        Dept dept = deptService.getOne(new QueryWrapper<Dept>().eq("name", user.getDeptName()));
                        if (dept != null) {
                            user.setDeptId(dept.getDeptId());
                            user.setDeptName(dept.getName());
                        }
                    }
                    baseMapper.insert(user);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、账号 " + user.getUserName() + " 导入成功");
                } else if (isUpdateSupport) {
                    this.updateById(user);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、账号 " + user.getUserName() + " 更新成功");
                } else {
                    failureNum++;
                    failureMsg.append("<br/>" + failureNum + "、账号 " + user.getUserName() + " 已存在");
                }
            } catch (Exception e) {
                failureNum++;
                String msg = "<br/>" + failureNum + "、账号 " + user.getUserName() + " 导入失败：";
                failureMsg.append(msg + e.getMessage());
            }
        }
        if (failureNum > 0) {
            failureMsg.insert(0, "很抱歉，导入失败！共 " + failureNum + " 条数据格式不正确，错误如下：");
            throw new BaseException(failureMsg.toString());
        } else {
            successMsg.insert(0, "恭喜您，数据已全部导入成功！共 " + successNum + " 条，数据如下：");
        }
        return successMsg.toString();
    }

}
