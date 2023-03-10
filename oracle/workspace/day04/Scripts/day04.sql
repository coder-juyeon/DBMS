/*JOBS 테이블에서 JOB_ID로 직원들의 JOB_TITLE, EMAIL, 성, 이름 검색*/
SELECT J.JOB_ID, JOB_TITLE, E.EMAIL, E.FIRST_NAME, E.LAST_NAME
FROM JOBS J INNER JOIN EMPLOYEES E ON J.JOB_ID = E.JOB_ID;

/*EMP 테이블의 SAL을 SALGRADE 테이블의 등급으로 나누기*/
/*SELECT E.ENAME, S.GRADE FROM SALGRADE s, EMP e  WHERE E.SAL >= S.LOSAL AND E.SAL <= S.HISAL;*/

SELECT *
FROM SALGRADE S JOIN EMP E 
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

/*EMPLOYEES 테이블에서 HIREDATE가 2003~2005년까지인 사원의 정보와 부서명 검색*/
/*SELECT * FROM EMPLOYEES
WHERE HIRE_DATE LIKE '03%' OR HIRE_DATE LIKE '04%' OR HIRE_DATE LIKE '05%';*/

SELECT D.DEPARTMENT_NAME, E.* 
FROM EMPLOYEES e JOIN DEPARTMENTS d 
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID AND
E.HIRE_DATE BETWEEN TO_DATE('2003', 'YYYY') AND TO_DATE('2005','YYYY');

/*시스템 날짜 포멧 바꾸기 근데 웬만하면 하지 않는게 좋음*/
/*SELECT SYS_CONTEXT('USERENV', 'NLS_DATE_FORMAT') FROM DUAL; 
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY';*/

/*JOB_TITLE 중 'Manager'라는 문자열이 포함된 직업들의 평균 연봉을 JOB_TITLE별로 검색*/
/*최대한 GROUPBY는 HAVING절까지 가지 말자*/
SELECT j.JOB_TITLE, AVG(E.SALARY) 
FROM JOBS j INNER JOIN EMPLOYEES e ON J.JOB_ID = E.JOB_ID 
GROUP BY J.JOB_TITLE
HAVING J.JOB_TITLE LIKE '%Manager%';

SELECT j.JOB_TITLE, AVG(E.SALARY) "AVERAGE OF SALARY"
FROM JOBS j INNER JOIN EMPLOYEES e ON J.JOB_ID = E.JOB_ID
AND JOB_TITLE LIKE '%Manager%'
GROUP BY J.JOB_TITLE;

/*EMP 테이블에서 ENAME에 L이 있는 사원들의 DNAME과 LOC 검색*/
/*조인 일:다 로 해주기*/
SELECT ENAME, D.DNAME, D.LOC  
FROM DEPT d  INNER JOIN EMP e ON E.DEPTNO = D.DEPTNO AND ENAME LIKE '%L%';

/*축구 선수들 중에서 각 팀별로 키가 가장 큰 선수들 전체 정보 검색*/
/*IN LINE VIEW -> FROM절의 서브쿼리*/
SELECT P1.*
FROM PLAYER P1 JOIN(
	SELECT TEAM_ID ,MAX(HEIGHT) HEIGHT FROM PLAYER p GROUP BY TEAM_ID
) P2
ON P1.TEAM_ID = P2.TEAM_ID AND P1.HEIGHT = P2.HEIGHT
ORDER BY P1.TEAM_ID;

/*(A,B) IN (C,D) : A = C AND B = D*/
SELECT *
FROM PLAYER p 
WHERE (TEAM_ID, HEIGHT) IN (SELECT TEAM_ID, MAX(HEIGHT) FROM PLAYER p GROUP BY TEAM_ID)
ORDER BY TEAM_ID;

/*EMP 테이블에서 사원의 이름과 매니저 이름을 검색*/
/*셀프조인 - 내 테이블과 내 테이블을 조인하는 것*/
SELECT E1.ENAME EMPLOYEE, E2.ENAME MANAGER 
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;


/*SQL 실행 순서*/
/*FROM > ON > JOIN > WHERE > GROUP BY > HAVING > SELECT > ORDER BY*/

/*[브론즈]*/
/*PLAYER 테이블에서 키가 NULL인 선수들은 키를 170으로 변경하여 평균 구하기(NULL 포함)*/
SELECT * FROM PLAYER p;

SELECT AVG(NVL(HEIGHT,'170')) AS 평균키
FROM PLAYER p;

/*[실버]*/
/*PLAYER 테이블에서 팀 별 최대 몸무게*/
SELECT * FROM PLAYER;

SELECT TEAM_ID, MAX(WEIGHT) "최대 몸무게"
FROM PLAYER p 
GROUP BY TEAM_ID;

/*[골드]*/
/*AVG 함수를 쓰지 않고 PLAYER 테이블에서 선수들의 평균 키 구하기(NULL 포함)*/
SELECT NVL(HEIGHT, 0) FROM PLAYER;

SELECT SUM(NVL(HEIGHT, 0))/ COUNT(NVL(HEIGHT, 0)) "선수들의 평균 키"
FROM PLAYER p;


/*[플래티넘]*/
/*DEPT 테이블의 LOC별 평균 급여를 반올림한 값과 각 LOC별 SAL 총 합을 조회, 반올림 : ROUND(값,반올림할 값)*/
/*0-> 1-> 소숫점 첫째자리 2-> 소숫점 둘째자리*/
SELECT * FROM DEPT d;
SELECT * FROM EMP e;

SELECT LOC, ROUND(AVG(E.SAL),0) AS 평균, SUM(E.SAL) AS 총합
FROM DEPT d JOIN EMP e ON D.DEPTNO = D.DEPTNO
GROUP BY LOC;

/*[다이아]*/
/*PLAYER 테이블에서 팀별 최대 몸무게인 선수 검색*/
SELECT * FROM PLAYER p;

SELECT TEAM_ID, MAX(WEIGHT)
FROM PLAYER p 
GROUP BY TEAM_ID;

SELECT P2.*
FROM (
	SELECT TEAM_ID, MAX(WEIGHT) AS WEIGHT 
	FROM PLAYER p GROUP BY TEAM_ID
) P1
JOIN PLAYER P2
ON P1.TEAM_ID = P2.TEAM_ID AND P1.WEIGHT = P2.WEIGHT
ORDER BY P1.TEAM_ID;

/*[마스터]*/
/*EMP 테이블에서 HIREDATE가 FORD의 입사년도와 같은 사원 전체 정보 조회*/
SELECT * FROM EMP e;

SELECT TO_CHAR(HIREDATE,'YYYY') 
FROM EMP e
WHERE ENAME = 'FORD';

SELECT *
FROM EMP 
WHERE TO_CHAR(HIREDATE,'YYYY') = (SELECT TO_CHAR(HIREDATE,'YYYY') FROM EMP e WHERE ENAME = 'FORD');

/*외부 조인*/
/*JOIN할 때 선행 또는 후행 중 하나의 테이블 정보를 모두 확인하고 싶을 때 사용한다.*/

/*DEPARTMENTS 테이블에서 매니저 이름 검색, 매니저가 없더라도 부서명 모두 검색*/
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

SELECT D.DEPARTMENT_NAME, NVL( E.LAST_NAME,'NO') || ' ' || NVL(E.FIRST_NAME,'NAME')  
FROM DEPARTMENTS D LEFT OUTER JOIN EMPLOYEES e
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID AND D.MANAGER_ID = E.EMPLOYEE_ID;

/*EMPLOYEES 테이블에서 사원의 매니저 이름, 사원의 이름 조회, 매니저가 없는 사원은 본인이 매니저임을 표시*/
SELECT EMPLOYEE_ID, FIRST_NAME, MANAGER_ID FROM EMPLOYEES e;

SELECT E1.FIRST_NAME "사원 이름", NVL(E2.FIRST_NAME, E1.FIRST_NAME) "매니저 이름"
FROM EMPLOYEES E1 LEFT OUTER JOIN EMPLOYEES E2
ON E1.MANAGER_ID = E2.EMPLOYEE_ID;

/*EMPLOYEES에서 각 사원별로 관리부서(매니저)와 소속부서(사원) 조회*/
SELECT E1.JOB_ID 관리부서, E2.JOB_ID 소속부서, E2.FIRST_NAME 이름
FROM
(
   SELECT JOB_ID, MANAGER_ID FROM EMPLOYEES
   GROUP BY JOB_ID, MANAGER_ID
) E1 
FULL OUTER JOIN EMPLOYEES E2
ON E1.MANAGER_ID = E2.EMPLOYEE_ID
ORDER BY 소속부서 DESC;

/*VIEW*/
/*CREATE VIEW [이름] AS [쿼리문]*/
/*
 * 기존의 테이블을 그대로 놔둔 채 필요한 컬럼들 및 새로운 컬럼을 만든 가상 테이블
 * 실제 데이터가 저장되는 것은 아니지만 VIEW를 통해서 데이터를 관리할 수 있다.
 * 
 * - 독립성 : 다른 곳에서 접근하지 못하도록 하는 성질
 * - 편리성 : 길고 복잡한 쿼리문을 매번 작성할 필요가 없다.
 * - 보안성 : 기존의 쿼리문이 보이지 않는다.
 * 
 * */

/*PLAYER 테이블에 나이 컬럼 추가한 뷰 만들기*/
/*FLOOR 소수점 버리기*/
CREATE VIEW VIEW_PLAYER AS
SELECT FLOOR((SYSDATE - BIRTH_DATE) / 365) AGE, P.* FROM PLAYER P;

SELECT * FROM VIEW_PLAYER;

/*EMPLOYEES 테이블에서 사원 이름과 그 사원의 매니저 이름이 있는 VIEW 만들기*/
SELECT * FROM EMPLOYEES e;

CREATE VIEW VIEW_EMPLOYEES AS
SELECT E1.FIRST_NAME AS EMPLOYEE_NAME, E2.FIRST_NAME AS MANAGER_NAME
FROM EMPLOYEES E1 JOIN EMPLOYEES E2
ON E1.MANAGER_ID = E2.EMPLOYEE_ID ;

SELECT * FROM VIEW_EMPLOYEES;

/*PLAYER 테이블에서 TEAM_NAME 컬럼을 추가한 VIEW 만들기*/
/*JOIN 바꾸기 TEAM이 앞으로 PLAYER가 뒤로*/
SELECT * FROM PLAYER;
SELECT * FROM TEAM;

SELECT P.*,T.TEAM_NAME 
FROM PLAYER P JOIN TEAM T ON P.TEAM_ID = T.TEAM_ID;

CREATE VIEW VIEW_PLAYER_TEAMNAME AS
SELECT P.*,T.TEAM_NAME 
FROM PLAYER P JOIN TEAM T ON P.TEAM_ID = T.TEAM_ID;

SELECT * FROM VIEW_PLAYER_TEAMNAME;

