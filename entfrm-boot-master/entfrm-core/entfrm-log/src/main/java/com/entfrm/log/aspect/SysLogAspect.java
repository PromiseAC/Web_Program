package com.entfrm.log.aspect;

import com.entfrm.base.constant.SqlConstants;
import com.entfrm.log.annotation.SysLog;
import com.entfrm.log.util.OperLogUtil;
import com.entfrm.security.util.SecurityUtil;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.*;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.core.task.TaskExecutor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.util.concurrent.CompletableFuture;



/**
 * 系统日志入库
 *
 * @author entfrm
 */
@Slf4j
@Aspect
@Component
@AllArgsConstructor
public class SysLogAspect {

    private final TaskExecutor taskExecutor;
    private final JdbcTemplate jdbcTemplate;

    private static long executeTime = 0;

    @Pointcut("@annotation(com.entfrm.log.annotation.SysLog)")
    public void logPointCut() {
    }

    @SneakyThrows
    @Around("logPointCut()")
    public Object around(ProceedingJoinPoint point) {
        String strClassName = point.getTarget().getClass().getName();
        String strMethodName = point.getSignature().getName();

        Long startTime = System.currentTimeMillis();
        Object obj = point.proceed();
        executeTime = System.currentTimeMillis() - startTime;

        log.debug("[类名]:{},[方法]:{},[耗时]:{}", strClassName, strMethodName, executeTime + "毫秒");

        return obj;
    }

    /**
     * 处理完请求后执行
     *
     * @param joinPoint 切点
     */
    @AfterReturning(pointcut = "logPointCut()")
    public void doAfterReturning(JoinPoint joinPoint) {
        handleLog(joinPoint, null);
    }

    /**
     * 拦截异常操作
     *
     * @param joinPoint 切点
     * @param e         异常
     */
    @AfterThrowing(value = "logPointCut()", throwing = "e")
    public void doAfterThrowing(JoinPoint joinPoint, Exception e) {
        handleLog(joinPoint, e);
    }

    protected void handleLog(final JoinPoint joinPoint, final Exception e) {
        try {
            // 获得注解
            SysLog operLog = getAnnotationLog(joinPoint);
            if (operLog == null) {
                return;
            }
            // 异常信息
            String errorMsg = "";
            if (e != null) {
                errorMsg = e.getMessage();
            }
            // 用户名
            String userName = SecurityUtil.getUserName();
            // 终端标识
            String clientId = "pc";

            PreparedStatementSetter pss = OperLogUtil.setOperLog(operLog.type().getValue() + "", operLog.value(), executeTime, userName, clientId, errorMsg);

            CompletableFuture.runAsync(() -> {
                jdbcTemplate.update(SqlConstants.OPER_LOG, pss);
            }, taskExecutor);

        } catch (Exception ex) {
            log.error("异常信息:{}", ex.getMessage());
        }
    }

    /**
     * 是否存在注解，如果存在就获取
     */
    @SneakyThrows
    private SysLog getAnnotationLog(JoinPoint joinPoint) {
        Signature signature = joinPoint.getSignature();
        MethodSignature methodSignature = (MethodSignature) signature;
        Method method = methodSignature.getMethod();

        if (method != null) {
            return method.getAnnotation(SysLog.class);
        }
        return null;
    }
}
