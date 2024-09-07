package com.entfrm.quartz.task;

import cn.hutool.core.util.StrUtil;
import org.springframework.stereotype.Component;

/**
 * 定时任务调度测试
 *
 * @author entfrm
 */
@Component("entfrmTask")
public class EntfrmTask {

    public void entfrmMultipleParams(String s, Boolean b, Long l, Double d, Integer i) {
        System.out.println(StrUtil.format("执行多参方法： 字符串类型{}，布尔类型{}，长整型{}，浮点型{}，整形{}", s, b, l, d, i));
    }

    public void entfrmParams(String params) {
        System.out.println("执行有参方法：" + params);
    }

    public void entfrmNoParams() {
        System.out.println("执行无参方法");
    }
}
