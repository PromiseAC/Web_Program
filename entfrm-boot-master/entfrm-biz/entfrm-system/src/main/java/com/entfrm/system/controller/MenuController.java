package com.entfrm.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.entfrm.base.api.R;
import com.entfrm.base.constant.AppConstants;
import com.entfrm.system.entity.Menu;
import com.entfrm.system.entity.RoleMenu;
import com.entfrm.system.service.MenuService;
import com.entfrm.system.service.RoleMenuService;
import com.entfrm.system.service.UserService;
import com.entfrm.system.vo.ResultVo;
import com.entfrm.log.annotation.SysLog;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * 菜单信息
 *
 * @author entfrm
 */
@RestController
@AllArgsConstructor
@RequestMapping(AppConstants.APP_SYSTEM + "/menu")
public class MenuController {

    private final MenuService menuService;
    private final RoleMenuService roleMenuService;
    private final UserService userService;

    private QueryWrapper<Menu> getQueryWrapper(Menu menu) {
        return new QueryWrapper<Menu>().like(StrUtil.isNotBlank(menu.getName()), "name", menu.getName()).eq(StrUtil.isNotBlank(menu.getStatus()), "status", menu.getStatus()).orderByAsc("sort");
    }

    @SaCheckPermission("menu_view")
    @GetMapping("/list")
    public R list(Menu menu) {
        List<Menu> menuList = menuService.list(getQueryWrapper(menu));
        if (menuList.size() > 0) {
            for (Menu menu1 : menuList) {
                if (StrUtil.isNotBlank(menu.getName()) || StrUtil.isNotBlank(menu.getStatus())) {
                    menu1.setParentId(0);
                }
            }
        }
        return R.ok(menuList, menuList.size());
    }

    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(menuService.getById(id));
    }

    @SysLog("菜单新增")
    @SaCheckPermission("menu_add")
    @PostMapping("/save")
    public R save(@RequestBody Menu menu) {
        menuService.save(menu);
        return R.ok();
    }

    @SysLog("菜单修改")
    @SaCheckPermission("menu_edit")
    @PutMapping("/update")
    public R update(@RequestBody Menu menu) {
        menuService.updateById(menu);
        return R.ok();
    }

    @SysLog("菜单删除")
    @SaCheckPermission("menu_del")
    @DeleteMapping("/remove/{id}")
    @ResponseBody
    public R remove(@PathVariable("id") Integer id) {
        if (menuService.count(new QueryWrapper<Menu>().eq("parent_id", id)) > 0) {
            return R.error("存在子菜单,不允许删除");
        }
        if (roleMenuService.count(new QueryWrapper<RoleMenu>().eq("menu_id", id)) > 0) {
            return R.error("菜单已分配,不允许删除");
        }
        menuService.removeById(id);
        return R.ok();
    }

    @SysLog("菜单状态更改")
    @SaCheckPermission("menu_edit")
    @GetMapping("/changeStatus")
    public R changeStatus(Menu menu) {
        menuService.updateById(menu);
        return R.ok();
    }

    /**
     * 加载所有菜单列表树
     */
    @GetMapping("/menuTree")
    @ResponseBody
    public R menuTree(@RequestParam(required = false) String applicationIds) {
        List<Menu> menuList = menuService.list(new QueryWrapper<Menu>().in(StrUtil.isNotBlank(applicationIds), "application_id", applicationIds).eq("status", "0").orderByAsc("sort"));
        return R.ok(menuList);
    }

    /**
     * 加载角色菜单列表树
     */
    @GetMapping("/roleMenuTree/{roleId}")
    public R roleMenuTree(@PathVariable Integer roleId) {
        List<Menu> menuList = menuService.list(new QueryWrapper<Menu>().eq("status", "0").orderByAsc("sort"));
        return R.ok(ResultVo.builder().result(menuList).extend(menuService.selectMenusByRoleId(roleId)).build());
    }

}
