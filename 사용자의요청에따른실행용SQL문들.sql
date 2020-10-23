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


-- 3. 정보변경 요청시 실행할 sql문
UPDATE 
       MEMBER
   SET USER_NAME = ?
     , PHONE = ?
     , EMAIL = ?
     , ADDRESS = ?
     , INTEREST = ?
     , MODIFY_DATE = SYSDATE
   WHERE USER_ID = ?;
   
   
-- 4. 갱신된 회원 정보 조회요청시 실행할 sql문

SELECT 
       USER_NO
     , USER_ID
     , USER_PWD
     , USER_NAME
     , PHONE
     , EMAIL
     , ADDRESS
     , INTEREST
     , ENROLL_DATE
     , MODIFY_DATE
     , STATUS
  FROM MEMBER
 WHERE USER_ID = ?
   AND STATUS = 'Y';
   
   
-- 5. 비밀번호 변경 요청시 실행할 sql문

UPDATE
       MEMBER
   SET USER_PWD = 변경할 비밀번호
 WHERE USER_ID = 로그인한 회원 아이디
   AND USER_PWD = 현재비밀번호
   
   
-- 6. 탈퇴 요청시 실행할 sql문

UPDATE
       MEMBER
   SET STATUS = 'N'
 WHERE USER_ID = ?
   AND USER_PWD = ?; 
   
   
-- * 공지사항 서비스


-- 1. 공지사항 리스트 조회

SELECT 
      NOTICE_NO
    , NOTICE_TITLE
    , USER_ID
    , COUNT
    , CREATE_DATE
  FROM NOTICE N
  JOIN MEMBER ON (NOTICE_WRITER = USER_NO)
  WHERE N.STATUS ='Y'
  ORDER
     BY NOTICE_NO DESC;
   
-- 2. 공지사항 등록요청시 실행할 sql문

INSERT INTO NOTICE(NOTICE_NO , NOTICE_TITLE , NOTICE_CONTENT ,NOTICE_WRITER
   )
   VALUES 
   (
     SEQ_NNO.NEXTVAL
   , ?
   , ?
   , ?
   )
   
   
-- 3. 사용자가 공지사항 상세조회 요청시 실행할 sql문
-- 3_1. 해당 공지사항만 조회수 1 증가

UPDATE
       NOTICE
   SET COUNT = COUNT + 1
 WHERE NOTICE_NO = ?
   AND STATUS = 'Y'
   ;
 
-- 3_2. 해당 공지사항만 조회하는 SQL 
-- PK역할은 화면에 노출되지 않더라도, 항상 챙겨가라!
SELECT
       NOTICE_NO
     , NOTICE_TITLE
     , NOTICE_CONTENT
     , USER_ID
     , CREATE_DATE
  FROM NOTICE N 
  JOIN MEMBER M ON (NOTICE_WRITER = USER_NO)
  WHERE NOTICE_NO = ?
    AND N.STATUS = 'Y';
        
  
-- 4. 공지사항 수정요청시 sql

UPDATE
       NOTICE
   SET NOTICE_TITLE = ?
     , NOTICE_CONTENT = ?
   WHERE NOTICE_NO = ?
     AND STATUS = 'Y'
     ;

-- 5. 공지사항 삭제요청시 sql문

UPDATE
       NOTICE
  SET  STATUS = 'N';
 WHERE NOTICE_NO = ?
 ;


--  * 일반 게시판 서비스
-- 1. 일반 게시판 리스트 조회
-- 1_1. 현재 일반 게시판 리스트 총 갯수 조회

SELECT  
       COUNT(*) LISTCOUNT
 FROM BOARD
WHERE BOARD_TYPE = 1
  AND STATUS = 'Y';
  
-- 1_2.  사용자가 요청한 페이지에 띄워줄 게시글 리스트 조회

SELECT *
  FROM (
        SELECT 
                ROWNUM RNUM
              , A.*
              
          FROM (
                    SELECT
                        BOARD_NO
                      , CATEGORY_NAME
                      , BOARD_TITLE
                      , USER_ID
                      , COUNT
                      , CREATE_DATE
                  FROM BOARD B
                  JOIN CATEGORY USING(CATEGORY_NO)
                  JOIN MEMBER ON (BOARD_WRITER = USER_NO)
                 WHERE BOARD_TYPE = 1
                   AND B.STATUS = 'Y'
                 ORDER 
                    BY BOARD_NO DESC 
                )A
        )


WHERE RNUM BETWEEN ? AND ?;      


  



-- 2. 일반게시판 작성하기 요청시 실행할 sql문
-- 2_1. 일반 게시글 내용 Board 테이블에 추가



INSERT
  INTO BOARD
 (
    BOARD_NO
  , BOARD_TYPE
  , CATEGORY_NO
  , BOARD_TITLE
  , BOARD_CONTENT
  , BOARD_WRITER
  , CREATE_DATE
 )
 VALUES
 (
    SEQ_BNO.NEXTVAL
  , 1
  , ?
  , ?
  , ?
  , ?
  , SYSDATE
 )



-- 2_2. 첨부파일 있을 경우 첨부파일 attachment테이블에 insert
-- 1:1이라면 보드테이블에 첨부파일 튜플을 넣어도되나, 1:m이기 때문에 따로 분류했다!
-- .CURRVAL => 가장 마지막 번호
INSERT
  INTO ATTACHMENT
  (
      FILE_NO
    , REF_BNO
    , ORIGIN_NAME
    , CHANGE_NAME
    , FILE_PATH
  )
  VALUES
  (
      SEQ_FNO.NEXTVAL
    , SEQ_BNO.CURRVAL
    ,
  )







