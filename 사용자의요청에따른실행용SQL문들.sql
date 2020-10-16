-- 사용자의 요청에 따른 실행할 sql 문들 --

-- * 회원서비스
-- 1. 로그인 요청시 실행할 sql문 (만약에 일치하는 회원 조회되면 오로지 "한 행"만 조회 된다!)
SELECT *
FROM MEMBER
WHERE USER_ID = ?
  AND USER_PWD = ?
  AND STATUS = 'Y';
  
--
-- 2. 회원가입 요청시 실행할 SQL문
INSERT INTO MEMBER(USER_NO, USER_ID, USER_PWD, USER_NAME, PHONE, EMAIL, ADDRESS, INTEREST)
VALUES(SEQ_UNO.NEXTVAL, ?, ?, ?, ?, ?, ?, ?);

INSERT INTO MEMBER(USER_NO, USER_ID, USER_PWD, USER_NAME, PHONE, EMAIL, ADDRESS, INTEREST) VALUES(SEQ_UNO.NEXTVAL, ?, ?, ?, ?, ?, ?, ?);