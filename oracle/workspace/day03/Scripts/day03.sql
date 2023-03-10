/*PLYAER 테이블에서 TEAM_ID가 'K01'인 선수*/
/*PLAYER 테이블에서 TEAM_ID가 'K01'이 아닌 선수*/
/*PLAYER 테이블에서 WEIGHT가 70이상이고 80이하인 선수*/
/*PLAYER 테이블에서 TEAM_ID가 'K03'이고 HEIGHT가 180미만인 선수*/
/*PLAYER 테이블에서 TEAM_ID가 'K06'이고 NICKNAME이 '제리'인 선수*/
/*PLAYER 테이블에서 HEIGHT가 170이상이고 WEIGHT가 80이상인 선수 이름*/
/*STADIUM 테이블에서 SEAT_COUNT가 30000 초과이고 410000이하인 경기장*/
/*PLAYER 테이블에서 TEAM_ID가 'K02'이거나 'K07'이고 포지션은 'MF'인 선수*/

/*PLYAER 테이블에서 TEAM_ID가 'K01'인 선수*/
SELECT * 
FROM PLAYER
WHERE TEAM_ID = 'K01'; 

/*PLAYER 테이블에서 TEAM_ID가 'K01'이 아닌 선수*/
SELECT * 
FROM PLAYER
WHERE TEAM_ID ^= 'K01' ;

/*PLAYER 테이블에서 WEIGHT가 70이상이고 80이하인 선수*/
SELECT *
FROM PLAYER
WHERE WEIGHT BETWEEN 70 AND 80;

/*PLAYER 테이블에서 TEAM_ID가 'K03'이고 HEIGHT가 180미만인 선수*/
SELECT * 
FROM PLAYER
WHERE TEAM_ID = 'K03' AND HEIGHT = 180; 

/*PLAYER 테이블에서 TEAM_ID가 'K06'이고 NICKNAME이 '제리'인 선수*/
SELECT *  
FROM PLAYER
WHERE TEAM_ID = 'K06' AND NICKNAME = '제리';

/*PLAYER 테이블에서 HEIGHT가 170이상이고 WEIGHT가 80이상인 선수 이름*/
SELECT PLAYER_NAME 
FROM PLAYER
WHERE HEIGHT >= 170 AND WEIGHT >= 80;

/*STADIUM 테이블에서 SEAT_COUNT가 30000 초과이고 410000이하인 경기장*/
SELECT * 
FROM STADIUM
WHERE SEAT_COUNT > 30000 AND SEAT_COUNT <= 41000; 

/*PLAYER 테이블에서 TEAM_ID가 'K02'이거나 'K07'이고 포지션은 'MF'인 선수*/
/*OR/AND중 AND가 우선순위*/
SELECT *
FROM PLAYER
WHERE TEAM_ID IN ('K02','K07') AND "POSITION" = 'MF';


SELECT * FROM PLAYER;
/*PLAYER 테이블에서 TEAM_ID가 'K01'인 선수 이름을 내 이름으로 바꾸기*/
UPDATE PLAYER
SET PLAYER_NAME='김주연'
WHERE TEAM_ID = 'K01';

/*PLAYER 테이블에서 POSITION이 'MF'인 선수 삭제하기*/
DELETE FROM PLAYER
WHERE "POSITION" ='MF';

/*PLAYER 테이블에서 HEIGHT가 180이상인 선수 삭제하기*/
DELETE FROM PLAYER
WHERE HEIGHT >= 180;

ROLLBACK;

/*PLAYER 테이블에서 NICKNAME이 NULL인 선수 검색*/
SELECT PLAYER_NAME, NVL(NICKNAME, '없음') 
FROM PLAYER
WHERE NICKNAME IS NULL;

SELECT *
FROM PLAYER
WHERE "POSITION" IS NULL;

/*PLAYER 테이블에서 POSITION이 NULL인 선수를 '미정'으로 변경 후 검색*/
SELECT PLAYER_NAME, NVL("POSITION" , '미정') 
FROM PLAYER;

/*PLAYER 테이블에서 NATION이 등록되어 있으면 '등록', 아니면 '미등록'으로 검색*/
SELECT PLAYER_NAME, NVL2(NATION,'등록' , '미등록')
FROM PLAYER;

/*AS(ALIAS): 별칭 */
/*SELECT절에서는 컬럼명 뒤에 띄어쓰고 작성하거나, AS 뒤에 작성한다.*/
/*공백 별칭은 ""으로*/
SELECT PLAYER_NAME, NVL(NICKNAME, '없음') AS 닉네임
FROM PLAYER
WHERE NICKNAME IS NULL;

/*선수 이름과 생일 조회*/
/*PLAYER 테이블에서 BACK_NO를 "등 번호"로, NICKNAME을 "선수 별명"으로 변경하여 검색*/
/*위 결과에서 NICKNAME이 NULL일 경우 '없음'으로 변경*/
SELECT BACK_NO AS "등 번호", NVL(NICKNAME, '없음') AS "선수 별명" 
FROM PLAYER;

/*CONCATENATION 연결, || */

/*PLAYER_NAME의 별명은 NICKNAME이다. */
SELECT PLAYER_NAME || '의 별명은' || NICKNAME || '이다.' AS 자기소개
FROM PLAYER;

/*PLAYER_NAME의 영어이름은 E_PLAYER_NAME이다.*/
SELECT PLAYER_NAME || '의 영어이름은' || E_PLAYER_NAME || '이다.' AS 자기소개
FROM PLAYER;

/*PLAYER_NAME의 포지션은 POSITION입니다.*/
SELECT PLAYER_NAME || '의 포지션은' || NVL("POSITION", '미정')  || '입니다.' AS 자기소개
FROM PLAYER;


/*LIKE : 포함된 문자열 값을 찾고, 문자열 개수도 제한을 줄 수 있다.
 * 
 * [컬럼명] LIKE '';
 * 
 * %: 모든 것
 * _: 글자 수
 * 
 * 예) '%A' : A로 끝나는 모든 값
 *    'A%' : A로 시작하는 모든 값
 *    '%A%' : A가 포함된 모든 값
 *    'A__' : A로 시작하고 3글자인 값
 *    '_A' : A로 끝나고 2글자인 값
 */*/
 
 /*TEAM 테이블에서 '천마'로 끝나는 팀 이름 찾기*/
SELECT * FROM TEAM WHERE TEAM_NAME LIKE '%천마';
 
SELECT * FROM PLAYER;
/*PLAYER 테이블에서 김씨 찾기*/
SELECT * FROM PLAYER WHERE PLAYER_NAME LIKE '김%';

/*PLAYER 테이블에서 김씨 두 자 찾기*/
SELECT * FROM PLAYER WHERE PLAYER_NAME LIKE '김_';

/*PLAYER 테이블에서 김씨와 이씨 찾기*/
SELECT * FROM PLAYER WHERE PLAYER_NAME LIKE '김%' OR PLAYER_NAME LIKE '이%';

/*PLAYER 테이블에서 이씨가 아닌 사람 찾기(NOT)*/
SELECT * FROM PLAYER WHERE NOT PLAYER_NAME LIKE '김%';

/*집계 함수: 결과는 무조건 1개
 * 
 * NULL은 포함시키지 않는다.
 * WHERE절에서 사용 불가
 * 
 * 평균	: AVG()
 * 최대값	: MAX()
 * 최소값	: MIN()
 * 총합	: SUM()
 * 개수	: COUNT()
 * 
 */

SELECT AVG(HEIGHT), MAX(HEIGHT), MIN(HEIGHT), SUM(HEIGHT), COUNT(HEIGHT)  FROM PLAYER;

/*PLAYER 테이블에서 HEIGHT로 총 선수 명수 검색*/
SELECT COUNT(NVL(HEIGHT, 0)) AS "총 선수명" FROM PLAYER;

/*정렬
 * 
 * ORDER BY 컬럼명, ...ASC : 오름차순
 * ORDER BY 컬럼명, ...DESC : 내림차순
 * 
 * */

/*키 순 정렬*/
SELECT PLAYER_NAME, HEIGHT, WEIGHT FROM PLAYER
WHERE HEIGHT IS NOT NULL
ORDER BY HEIGHT DESC, WEIGHT DESC;

/*
 * GROUP BY : ~별 (예: 포지션 별 평균 키)
 * 
 * GROUP BY 컬럼명 HAVING 조건식
 * WHERE 절에 우선적으로 처리할 조건식을 작성해야 속도가 빠르다.
 * HAVING 절에서는 집계함수 사용 가능
 * */

/*PLAYER 테이블에서 포지션 종류 검색*/
SELECT "POSITION", COUNT("POSITION")  FROM PLAYER
WHERE "POSITION" IS NOT NULL
GROUP BY "POSITION";


/*PLAYER 테이블에서 몸무게가 80이상인 선수들의 평균 키가 180이상인 포지션 검색*/
SELECT "POSITION", AVG(HEIGHT), MIN(WEIGHT) 
FROM PLAYER
WHERE WEIGHT >= 80 
GROUP BY "POSITION" 
HAVING AVG(HEIGHT) >= 180;

/* EMPLOYEES 테이블에서 JOB_IB별 평균 SALARY가 10000미만인 JOB_ID 검색, JOB_ID 알파벳순 정렬*/
SELECT JOB_ID, AVG(SALARY)  
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING AVG(SALARY) < 10000
ORDER BY JOB_ID ASC;


/*SUB QUERY
 * 
 * FROM절 : IN LINE VIEW
 * SELECT절 : SCALAR SUB QUERY
 * WHERE절 : SUB QUERY
 * 
 * */
/* PLAYER 테이블에서 TEAM_ID가 'K01' 인 선수 중 POSITION이 'GK'인 선수*/
SELECT * FROM
(
	SELECT * FROM PLAYER
	WHERE TEAM_ID  = 'K01'
)
WHERE "POSITION" = 'GK';

/*정남일 선수가 소속된 팀의 선수들 조회*/
SELECT PLAYER_NAME
FROM PLAYER
WHERE TEAM_ID = (
	SELECT TEAM_ID FROM PLAYER
	WHERE PLAYER_NAME = '정남일'
);

/*PLAYER 테이블에서 전체 평균 키와 포지션별 평균 키 구하기*/
SELECT AVG(HEIGHT) AS "전체 평균 키"
FROM PLAYER;

SELECT "POSITION" , AVG(HEIGHT) AS "포지선별 평균 키", (SELECT AVG(HEIGHT)
FROM PLAYER) AS "전체 평균 키"
FROM PLAYER
WHERE "POSITION" IS NOT NULL
GROUP BY "POSITION";


/*경기장 중 경기 일정이 20120501~20120502 사이에 있는 경기장 전체 정보 조회*/
SELECT * FROM STADIUM
WHERE STADIUM_ID IN
(
   SELECT STADIUM_ID FROM SCHEDULE
   WHERE SCHE_DATE BETWEEN '20120501' AND '20120502'
);

/*EMPLOYEES 테이블에서 평균 급여보다 낮은 사원들의 급여를 20% 인상*/
SELECT * FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES);

UPDATE EMPLOYEES
SET SALARY = SALARY * 1.2
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Bruce';

/*확인*/
SELECT EMPLOYEE_ID, SALARY, (SELECT AVG(SALARY) 
FROM EMPLOYEES) AS "평균 급여"
FROM EMPLOYEES
WHERE SALARY < (
SELECT AVG(SALARY) 
FROM EMPLOYEES
);

/*급여 인상*/
UPDATE EMPLOYEES 
SET SALARY = SALARY * 1.2
WHERE SALARY < (
SELECT AVG(SALARY) 
FROM EMPLOYEES
);

ROLLBACK;

/*PLAYER 테이블에서 NICKNAME이 NULL인 선수들을 정태민 선수의 닉네임을 바꾸기*/
UPDATE PLAYER
SET NICKNAME = (SELECT NICKNAME FROM PLAYER WHERE PLAYER_NAME = '정태민')
WHERE NICKNAME IS NULL;

SELECT * FROM PLAYER;

/*PLAYER 테이블에서 평균 키보다 큰 선수들 삭제*/
DELETE FROM PLAYER
WHERE HEIGHT > (SELECT AVG(HEIGHT) FROM PLAYER);

SELECT AVG(HEIGHT) FROM PLAYER;
SELECT MAX(HEIGHT) FROM PLAYER;

/*JOIN
 * 
 * 여러 테이블에 흩어져 있는 정보 중
 * 사용자가 필요한 정보만 가져와서 가상의 테이블처럼 만들고 결과를 보여주는 것.
 * 정규화를 통해 조회 테이블이 너무 많이 쪼개져 있으면 작업이 불편하기 때문에
 * 입력, 수정, 삭제의 성능을 향상시키기 위해서 JOIN을 통해 합친 후 사용한다.
 * 
 * */

/*EMP 테이블 사원번호로 DEPT 테이블의 지역 검색*/
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT ENAME, LOC 
FROM DEPT D JOIN EMP E 
ON D.DEPTNO = E.DEPTNO;

/*PLAYER 테이블에서 송종국 선수가 속한 팀의 전화번호 검색하기*/
/*JOIN은 선행쪽이 1 후행이 다*/
SELECT T.TEAM_ID, PLAYER_NAME, TEL 
FROM TEAM T INNER JOIN PLAYER P
ON T.TEAM_ID = P.TEAM_ID AND P.PLAYER_NAME = '송종국';

/*---------------------------------과제----------------------------------------*/
/*JOBS 테이블에서 JOB_ID로 직원들의 JOB_TITLE, EMAIL, 성, 이름 검색*/
SELECT J.JOB_ID, JOB_TITLE, E.EMAIL, E.FIRST_NAME, E.LAST_NAME
FROM JOBS J INNER JOIN EMPLOYEES E ON J.JOB_ID = E.JOB_ID;

/*EMP 테이블의 SAL을 SALGRADE 테이블의 등급으로 나누기*/
/*SALGRADE의 하이와 로우가 EMP의 SAL안에 있다면 SALGRADE의 등급으로 정하고 EMP에 SALGRADE를 추가시켜서 넣어준다?*/
SELECT * FROM EMP e2;
SELECT * FROM SALGRADE s2;
SELECT E.ENAME, S.GRADE FROM SALGRADE s, EMP e  WHERE E.SAL >= S.LOSAL AND E.SAL <= S.HISAL;

/*EMPLOYEES 테이블에서 HIREDATE가 2003~2005년까지인 사원의 정보와 부서명 검색*/
SELECT * FROM EMPLOYEES

SELECT * FROM EMPLOYEES
WHERE HIRE_DATE LIKE '03%' OR HIRE_DATE LIKE '04%' OR HIRE_DATE LIKE '05%';

/*JOB_TITLE 중 'Manager'라는 문자열이 포함된 직업들의 평균 연봉을 JOB_TITLE별로 검색*/
/*JOBS와 EMPLOYEES 조인을 한 후에 JOB_ID로 연결시켜 주고 'Manager'라는 문자열이 포함된것만 JOB_TITLE별로 묶어서 E.SALARY를 구해서 평균내기 */
SELECT * FROM JOBS j;
SELECT * FROM EMPLOYEES


SELECT j.JOB_TITLE, AVG(E.SALARY) 
FROM JOBS j INNER JOIN EMPLOYEES e ON J.JOB_ID = E.JOB_ID 
GROUP BY J.JOB_TITLE
HAVING J.JOB_TITLE LIKE '%Manager%';

/*EMP 테이블에서 ENAME에 L이 있는 사원들의 DNAME과 LOC 검색*/
SELECT * FROM EMP e;
SELECT * FROM DEPT d; 

/*확인용*/
/*SELECT ENAME, D.DNAME, D.LOC  
FROM EMP e INNER JOIN DEPT d ON E.DEPTNO = D.DEPTNO AND ENAME LIKE '%L%';*/

SELECT D.DNAME, D.LOC  
FROM EMP e INNER JOIN DEPT d ON E.DEPTNO = D.DEPTNO AND ENAME LIKE '%L%';

/*축구 선수들 중에서 각 팀별로 키가 가장 큰 선수들 전체 정보 검색*/
/*-----------------------잘 모르겠음--------------------*/
SELECT * FROM PLAYER p;

/*TEAM별로 묶어줘야 하는데 묶으면 전체정보를 볼 수 없어서 어떻게 해야 할지?*/
SELECT *
FROM PLAYER p 
WHERE HEIGHT IN (SELECT MAX(HEIGHT) FROM PLAYER p GROUP BY TEAM_ID);

SELECT TEAM_ID, MAX(HEIGHT) 
	FROM PLAYER p 
	GROUP BY TEAM_ID

/*EMP 테이블에서 사원의 이름과 매니저 이름을 검색*/
/* 사원의 이름? 문제 이해 못함*/
SELECT * FROM EMP e;

SELECT ENAME, JOB 
FROM EMP e 
WHERE JOB = 'MANAGER';

