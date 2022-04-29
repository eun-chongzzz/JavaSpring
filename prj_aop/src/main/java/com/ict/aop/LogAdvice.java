package com.ict.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {// 보조기능들을 작성하는 클래스
	
	// 로직 실행 이전
	@Before("execution(* com.ict.service.SampleService*.*(..))")
	public void logBefore() {
		log.info("================");
	}
	 
	@Before("execution(* com.ict.service.SampleService*.doAdd(String, String)) && args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) {
		
		log.info("str1: " + str1);
		log.info("str2: " + str2);
	}
	
	@After("execution(* com.ict.service.SampleService*.*(..))")
	public void logAfter() {
		log.info("*****************");
	}
	
	// 예외가 발생했을 때
	@AfterThrowing(pointcut = "execution(* com.ict.service.SampleService*.*(..))", throwing="exception")
	public void logException(Exception exception) {
		log.info("Exception....!!!!");
		log.info("exception: " + exception);
	}
	
	// Before + After (실행소요시간을 구하는 Advice)
	@Around("execution(* com.ict.service.SampleService*.*(..))")
				// 앞으로 실행될 메서드(pointcut)에 대한 정보를 pjp에 저장중
	public Object logTime(ProceedingJoinPoint pjp) {
		
		// 시작시간 저장
		long start = System.currentTimeMillis();
		
		log.info("Target : " + pjp.getTarget()); // 해당 메서드 명칭
		log.info("Param : " + Arrays.toString(pjp.getArgs())); // 해당 메서드 파라미터들
		
		Object result = null;
		
		try {
			result = pjp.proceed(); // .proceed(); 핵심로직 실행을 명령하는 명령어
									// 이 로직(핵심로직)을 기점으로 위 = Before, 아래 = After.
		}catch(Throwable e)  {
			// 예외 발생시
			e.printStackTrace();
		}
		// 끝나는시간 저장
		long end = System.currentTimeMillis();
		
		log.info("TIME : " + (end - start)); // 소요시간 계산 후 로그찍기
		return result;
	}

}
