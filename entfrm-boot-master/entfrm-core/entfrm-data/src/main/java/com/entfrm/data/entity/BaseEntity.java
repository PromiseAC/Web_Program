package com.entfrm.data.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;
import java.util.Map;

/**
 * @author yong
 * @date 2020/2/1
 * @description Entity基类
 */
@Data
@Accessors(chain = true)
public class BaseEntity implements Serializable {
    protected static final long serialVersionUID = 1L;

    /**
     * 创建者
     */
    @TableField(value = "create_by", fill = FieldFill.INSERT)
    protected String createBy;

    /**
     * 创建时间
     */

    @TableField(value = "create_time", fill = FieldFill.INSERT)
    protected Date createTime;

    /**
     * 更新者
     */
    @TableField(value = "update_by", fill = FieldFill.UPDATE)
    protected String updateBy;

    /**
     * 更新时间
     */
    @TableField(value = "update_time", fill = FieldFill.UPDATE)
    protected Date updateTime;

    /**
     * 备注
     */
    protected String remarks;

    /**
     * 删除标志（0代表存在 1代表删除）
     */
    @TableLogic
    @JsonIgnore
    protected String delFlag;

    @TableField(exist = false)
    @JsonIgnore
    private String sqlFilter;

    @TableField(exist = false)
    @JsonIgnore
    private Map<String, Object> params;
}
