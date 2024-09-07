package com.entfrm.data.util;

import cn.hutool.core.collection.ListUtil;
import cn.hutool.extra.spring.SpringUtil;
import com.entfrm.base.constant.SqlConstants;
import com.entfrm.base.util.StrUtil;
import com.entfrm.security.entity.EntfrmUser;
import com.entfrm.security.util.SecurityUtil;
import lombok.experimental.UtilityClass;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

/**
 * @author entfrm
 * @date 2021-03-28
 * @description 数据权限util
 */
@UtilityClass
public class DataAuthUtil {

    private final JdbcTemplate jdbcTemplate = SpringUtil.getBean(JdbcTemplate.class);
    /**
     * 全部数据权限
     */
    public final String DATA_SCOPE_ALL = "1";

    /**
     * 自定数据权限
     */
    public final String DATA_SCOPE_CUSTOM = "2";

    /**
     * 部门数据权限
     */
    public final String DATA_SCOPE_DEPT = "3";

    /**
     * 部门及以下数据权限
     */
    public final String DATA_SCOPE_DEPT_AND_CHILD = "4";

    /**
     * 仅本人数据权限
     */
    public final String DATA_SCOPE_SELF = "5";

    public String getSQLFilter(String tableAlias) {
        if (StrUtil.isNotBlank(tableAlias)) {
            tableAlias += ".";
        }
        StringBuilder sqlFilter = new StringBuilder();
        EntfrmUser user = SecurityUtil.getUser();
        List<Integer> roles = SecurityUtil.getRoleList();
        if (roles != null && roles.size() > 0) {
            sqlFilter.append(" (");
            for (int i = 0; i < roles.size(); i++) {
                String dataScope = jdbcTemplate.queryForObject(SqlConstants.ROLE_DATASCOPE, String.class, roles.get(i));
                if (i != 0) {
                    sqlFilter.append(" OR");
                }
                if (DATA_SCOPE_ALL.equals(dataScope)) {
                    sqlFilter = new StringBuilder();
                    break;
                } else if (DATA_SCOPE_CUSTOM.equals(dataScope)) {
                    sqlFilter.append(StrUtil.format(" {}dept_id IN ( SELECT dept_id FROM sys_role_dept WHERE role_id = {} ) ", tableAlias, roles.get(i)));
                } else if (DATA_SCOPE_DEPT.equals(dataScope)) {
                    sqlFilter.append(StrUtil.format(" {}dept_id = {} ", tableAlias, user.getDeptId()));
                } else if (DATA_SCOPE_DEPT_AND_CHILD.equals(dataScope)) {
                    sqlFilter.append(StrUtil.format(
                            " {}dept_id IN ( SELECT dept_id FROM sys_dept WHERE dept_id = {} or find_in_set( {} , ancestors ) )", tableAlias, user.getDeptId(), user.getDeptId()));
                } else if (DATA_SCOPE_SELF.equals(dataScope)) {
                    sqlFilter.append(StrUtil.format(" create_by = '{}' ", user.getUserName()));
                }
            }
            if (StrUtil.isNotBlank(sqlFilter)) {
                sqlFilter.append(")");
            }
        }
        return sqlFilter.toString();
    }
}
