package com.githrd.figurium.aop;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;

@Slf4j
//@Aspect
//@Component
public class LoggingAspect {

    // com.githrd.figurium 패키지 내 controller 하위 패키지의 모든 클래스와 메서드에 적용
    @Pointcut("execution(* com.githrd.figurium..controller..*(..))")
    private void cut() {}

    // 메서드 호출 전에 로그 기록
    @Before("cut()")
    public void beforeMethod(JoinPoint joinPoint) {
        try {
            // 메서드 정보 받아오기
            Method method = getMethod(joinPoint);
            if (method != null) {
                log.info("======= 메서드 호출 시작 =======");
                log.info("클래스 이름 : {}", method.getDeclaringClass().getSimpleName());
                log.info("메서드 이름 : {}()", method.getName());
            } else {
                log.warn("메서드 정보를 가져올 수 없습니다.");
            }

            // 파라미터 받아오기
            Object[] args = joinPoint.getArgs();
            if (args != null && args.length > 0) {
                for (Object arg : args) {
                    if (arg != null) {
                        log.info("파라미터 타입 : {}", arg.getClass().getSimpleName());
                        log.info("파라미터 값 : {}", arg.toString());
                    } else {
                        log.info("파라미터 값 = null");
                    }
                }
            } else {
                log.info("파라미터가 없습니다.");
            }
        } catch (ClassCastException e) {
            log.warn("JoinPoint의 서명을 MethodSignature로 캐스팅할 수 없습니다.", e);
        }
    }

    // 메서드 호출 후 로그 기록
    @AfterReturning(value = "cut()", returning = "returnObj")
    public void afterMethod(JoinPoint joinPoint, Object returnObj) {
        try {
            // 메서드 정보 받아오기
            Method method = getMethod(joinPoint);
            if (method != null) {
                log.info("======= 메서드 호출 종료 =======");
                log.info("클래스 이름 : {}", method.getDeclaringClass().getSimpleName());
                log.info("메서드 이름 : {}()", method.getName());
            } else {
                log.warn("메서드 정보를 가져올 수 없습니다.");
            }

            // 반환 값이 null일 수 있으므로 null 체크 추가
            if (returnObj == null) {
                log.info("반환 값이 null입니다.");
            } else {
                log.info("반환 타입 : {}", returnObj.getClass().getSimpleName());
                log.info("반환 값 : {}", returnObj.toString());
            }
        } catch (ClassCastException e) {
            log.warn("JoinPoint의 서명을 MethodSignature로 캐스팅할 수 없습니다.", e);
        }
    }

    // JoinPoint로 메서드 정보 가져오기
    private Method getMethod(JoinPoint joinPoint) {
        try {
            MethodSignature signature = (MethodSignature) joinPoint.getSignature();
            return signature.getMethod();
        } catch (ClassCastException e) {
            log.warn("JoinPoint의 signature를 MethodSignature로 캐스팅할 수 없습니다.", e);
            return null;
        }
    }
}
