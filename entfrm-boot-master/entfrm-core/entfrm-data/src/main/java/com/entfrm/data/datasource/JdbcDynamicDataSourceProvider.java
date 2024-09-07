package com.entfrm.data.datasource;

import com.baomidou.dynamic.datasource.provider.AbstractJdbcDataSourceProvider;
import com.baomidou.dynamic.datasource.spring.boot.autoconfigure.DataSourceProperty;
import com.entfrm.data.constant.DataSourceConstants;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

/**
 * @author entfrm
 * @date 2020/2/6
 * <p>
 * 从数据源中获取 配置信息
 */
public class JdbcDynamicDataSourceProvider extends AbstractJdbcDataSourceProvider {

    private final DruidDataSourceProperties properties;

    public JdbcDynamicDataSourceProvider(DruidDataSourceProperties properties) {
        super(properties.getDriverClassName(), properties.getUrl(), properties.getUsername(), properties.getPassword());
        this.properties = properties;
    }

    /**
     * 执行语句获得数据源参数
     *
     * @param statement 语句
     * @return 数据源参数
     * @throws SQLException sql异常
     */
    @Override
    protected Map<String, DataSourceProperty> executeStmt(Statement statement) throws SQLException {
        Map<String, DataSourceProperty> map = new HashMap<>(8);
        // 添加默认主数据源
        DataSourceProperty ds = new DataSourceProperty();
        ds.setUsername(properties.getUsername());
        ds.setPassword(properties.getPassword());
        ds.setUrl(properties.getUrl());
        ds.setDriverClassName(properties.getDriverClassName());
        map.put(DataSourceConstants.DS_MASTER, ds);

        ResultSet rs = statement.executeQuery(DataSourceConstants.DS_QUERY_SQL);
        while (rs.next()) {
            String name = rs.getString(DataSourceConstants.DS_NAME);
            String username = rs.getString(DataSourceConstants.DS_USER_NAME);
            String password = rs.getString(DataSourceConstants.DS_USER_PWD);
            String url = rs.getString(DataSourceConstants.DS_JDBC_URL);
            String driverClassName = rs.getString(DataSourceConstants.DS_JDBC_DRIVER);
            DataSourceProperty property = new DataSourceProperty();
            property.setDriverClassName(driverClassName);
            property.setUsername(username);
            property.setPassword(password);
            property.setUrl(url);
            map.put(name, property);
        }

        return map;
    }

}
