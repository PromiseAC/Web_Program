package com.entfrm.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.entfrm.base.api.R;
import com.entfrm.base.constant.AppConstants;
import com.entfrm.log.annotation.SysLog;
import com.entfrm.system.entity.Dept;
import com.entfrm.system.entity.RoleDept;
import com.entfrm.system.entity.User;
import com.entfrm.system.service.DeptService;
import com.entfrm.system.service.RoleDeptService;
import com.entfrm.system.service.UserService;
import com.entfrm.system.vo.ResultVo;
import lombok.AllArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 机构信息
 *
 * @author entfrm
 */
@RestController
@AllArgsConstructor
@RequestMapping(AppConstants.APP_SYSTEM + "/dept")
public class DeptController {

    private final DeptService deptService;
    private final UserService userService;
    private final RoleDeptService roleDeptService;
    private final RedisTemplate redisTemplate;

    private QueryWrapper<Dept> getQueryWrapper(Dept dept) {
        return new QueryWrapper<Dept>().like(StrUtil.isNotBlank(dept.getName()), "name", dept.getName()).eq(StrUtil.isNotBlank(dept.getCode()), "code", dept.getCode());
    }

    @SaCheckPermission("dept_view")
    @GetMapping("/list")
    public R list(Dept dept) {
        List<Dept> deptList = deptService.list(getQueryWrapper(dept));
        if (deptList.size() > 0) {
            for (Dept dept1 : deptList) {
                if (StrUtil.isNotBlank(dept.getName()) || StrUtil.isNotBlank(dept.getCode())) {
                    dept1.setParentId(0);
                }
            }
        }
        return R.ok(deptList, deptList.size());
    }

    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(deptService.getById(id));
    }

    @SysLog("机构新增")
    @SaCheckPermission("dept_add")
    @PostMapping("/save")
    public R save(@RequestBody Dept dept) {
        Dept info = null;
        if (0 != dept.getParentId()) {
            info = deptService.getById(dept.getParentId());
            dept.setAncestors(info.getAncestors() + "," + dept.getParentId());
        } else {
            dept.setAncestors("0");
        }
        deptService.save(dept);
        return R.ok();
    }

    @SysLog("机构修改")
    @SaCheckPermission("dept_edit")
    @PutMapping("/update")
    public R update(@RequestBody Dept dept) {
        Dept info = null;
        if (0 != dept.getParentId()) {
            info = deptService.getById(dept.getParentId());
            dept.setAncestors(info.getAncestors() + "," + dept.getParentId());
        } else {
            dept.setAncestors("0");
        }
        deptService.updateById(dept);
        //更新用户机构名称
        new Thread() {
            public void run() {
                List<User> userList = userService.list(new QueryWrapper<User>().eq("dept_id", dept.getDeptId()));
                for (User user : userList) {
                    user.setDeptName(dept.getName());
                    userService.updateById(user);
                }
            }
        }.start();
        return R.ok();
    }

    @SysLog("机构删除")
    @SaCheckPermission("dept_del")
    @DeleteMapping("/remove/{id}")
    public R remove(@PathVariable("id") Integer id) {
        if (deptService.getOne(new QueryWrapper<Dept>().eq("parent_id", id)) != null) {
            return R.error("存在下级机构,不允许删除");
        }
        if (userService.getOne(new QueryWrapper<User>().eq("dept_id", id)) != null) {
            return R.error("机构存在用户,不允许删除");
        }
        deptService.removeById(id);
        redisTemplate.delete("deptList");
        redisTemplate.delete("regionList");
        return R.ok();
    }

    @SysLog("机构状态更改")
    @SaCheckPermission("dept_edit")
    @GetMapping("/changeStatus")
    public R changeStatus(Dept dept) {
        deptService.updateById(dept);
        return R.ok();
    }

    /**
     * 加载机构列表树
     */
    @GetMapping("/deptTree")
    @ResponseBody
    public R deptTree() {
        List<Dept> deptList = deptService.list(new QueryWrapper<Dept>().orderByAsc("sort"));
        return R.ok(deptService.buildTree(deptList, 0));
    }

    /**
     * 加载角色机构（数据权限）列表树
     */
    @GetMapping("/roleDeptTree/{roleId}")
    @ResponseBody
    public R roleDeptTree(@PathVariable Integer roleId) {
        List<Dept> deptList = deptService.list(new QueryWrapper<Dept>().orderByAsc("sort"));
        List<Integer> depts = roleDeptService.list(new QueryWrapper<RoleDept>().eq("role_id", roleId))
                .stream().map(roleMenu -> roleMenu.getDeptId()).collect(Collectors.toList());
        return R.ok(ResultVo.builder().result(deptService.buildTree(deptList, 0)).extend(depts).build());
    }

}
