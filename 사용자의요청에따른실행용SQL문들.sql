-- ������� ��û�� ���� ������ sql ���� --

-- * ȸ������
-- 1. �α��� ��û�� ������ sql�� (���࿡ ��ġ�ϴ� ȸ�� ��ȸ�Ǹ� ������ "�� ��"�� ��ȸ �ȴ�!)
SELECT *
FROM MEMBER
WHERE USER_ID = ?
  AND USER_PWD = ?
  AND STATUS = 'Y';
  
--
-- 2. ȸ������ ��û�� ������ SQL��
INSERT INTO MEMBER(USER_NO, USER_ID, USER_PWD, USER_NAME, PHONE, EMAIL, ADDRESS, INTEREST)
VALUES(SEQ_UNO.NEXTVAL, ?, ?, ?, ?, ?, ?, ?);

INSERT INTO MEMBER(USER_NO, USER_ID, USER_PWD, USER_NAME, PHONE, EMAIL, ADDRESS, INTEREST) VALUES(SEQ_UNO.NEXTVAL, ?, ?, ?, ?, ?, ?, ?);


-- 3. �������� ��û�� ������ sql��
UPDATE 
       MEMBER
   SET USER_NAME = ?
     , PHONE = ?
     , EMAIL = ?
     , ADDRESS = ?
     , INTEREST = ?
     , MODIFY_DATE = SYSDATE
   WHERE USER_ID = ?;
   
   
-- 4. ���ŵ� ȸ�� ���� ��ȸ��û�� ������ sql��

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
   
   
-- 5. ��й�ȣ ���� ��û�� ������ sql��

UPDATE
       MEMBER
   SET USER_PWD = ������ ��й�ȣ
 WHERE USER_ID = �α����� ȸ�� ���̵�
   AND USER_PWD = �����й�ȣ
   
   
-- 6. Ż�� ��û�� ������ sql��

UPDATE
       MEMBER
   SET STATUS = 'N'
 WHERE USER_ID = ?
   AND USER_PWD = ?; 
   

-- ajax. ���̵� �ߺ�üũ ��û�� ������ sql��

SELECT
       COUNT(*)
  FROM MEMBER
 WHERE USER_ID = ?;




-- * �������� ����


-- 1. �������� ����Ʈ ��ȸ

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
   
-- 2. �������� ��Ͽ�û�� ������ sql��

INSERT INTO NOTICE(NOTICE_NO , NOTICE_TITLE , NOTICE_CONTENT ,NOTICE_WRITER
   )
   VALUES 
   (
     SEQ_NNO.NEXTVAL
   , ?
   , ?
   , ?
   )
   
   
-- 3. ����ڰ� �������� ����ȸ ��û�� ������ sql��
-- 3_1. �ش� �������׸� ��ȸ�� 1 ����

UPDATE
       NOTICE
   SET COUNT = COUNT + 1
 WHERE NOTICE_NO = ?
   AND STATUS = 'Y'
   ;
 
-- 3_2. �ش� �������׸� ��ȸ�ϴ� SQL 
-- PK������ ȭ�鿡 ������� �ʴ���, �׻� ì�ܰ���!
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
        
  
-- 4. �������� ������û�� sql

UPDATE
       NOTICE
   SET NOTICE_TITLE = ?
     , NOTICE_CONTENT = ?
   WHERE NOTICE_NO = ?
     AND STATUS = 'Y'
     ;

-- 5. �������� ������û�� sql��

UPDATE
       NOTICE
  SET  STATUS = 'N';
 WHERE NOTICE_NO = ?
 ;


--  * �Ϲ� �Խ��� ����
-- 1. �Ϲ� �Խ��� ����Ʈ ��ȸ
-- 1_1. ���� �Ϲ� �Խ��� ����Ʈ �� ���� ��ȸ

SELECT  
       COUNT(*) LISTCOUNT
 FROM BOARD
WHERE BOARD_TYPE = 1
  AND STATUS = 'Y';
  
-- 1_2.  ����ڰ� ��û�� �������� ����� �Խñ� ����Ʈ ��ȸ

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


  



-- 2. �ϹݰԽ��� �ۼ��ϱ� ��û�� ������ sql��
-- 2_1. �Ϲ� �Խñ� ���� Board ���̺� �߰�



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



-- 2_2. ÷������ ���� ��� ÷������ attachment���̺� insert
-- 1:1�̶�� �������̺� ÷������ Ʃ���� �־�ǳ�, 1:m�̱� ������ ���� �з��ߴ�!
-- .CURRVAL => ���� ������ ��ȣ
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
    , ?
    , ?
    , ?
  )


--  3. ����ȸ ��û�� ������ sql��
-- 3_1. �ش� �Խñ� ��ȸ�� ����
UPDATE 
       BOARD
   SET COUNT = COUNT+1
 WHERE BOARD_NO = 110
   AND STATUS = 'Y'
   ;

-- 3_2. �ش� �Խñ� ���� ��ȸ�� SQL��
SELECT
       BOARD_NO
     , CATEGORY_NAME
     , BOARD_TITLE
     , BOARD_CONTENT
     , USER_ID
     , CREATE_DATE
  FROM BOARD B
  LEFT JOIN CATEGORY USING(CATEGORY_NO)
  JOIN MEMBER ON(BOARD_WRITER = USER_NO)
 WHERE B.STATUS = 'Y'
   AND BOARD_NO = ?
    ;

-- 3_3.�ش� �Խñ� ÷������ ��ȸSQL
SELECT
       FILE_NO
     , ORIGIN_NAME
     , CHANGE_NAME
     , FILE_PATH

FROM ATTACHMENT
WHERE STATUS = 'Y'
  AND REF_BNO = ?
ORDER
   BY FILE_LEVEL ASC
  ;
      

-- 4. �ϹݰԽ��� �����ϱ� ��û�� ������ sql��
-- BOARD ���̺� ���� ���� 
UPDATE
       BOARD
   SET CATEGORY_NO = ?
     , BOARD_TITLE = ?
     , BOARD_CONTENT = ? 
 WHERE BOARD_NO = ?
   AND STATUS = 'Y'
     
-- ���� �Ѿ�� ÷������ ���� ���
--> ������ ÷������ �־��� ���(ATTACHMENT�� ��� ���� => UPDATE)
UPDATE
       ATTACHMENT
   SET ORIGIN_NAME = ?
     , CHANGE_NAME = ?
     , FILE_PATH = ?
 WHERE FILE_NO = ?;
 

--> ������ ÷������ ������ ���(ATTACHMENT�� ��� ���� => INSERT)
INSERT 
       INTO ATTACHMENT
       (
         FILE_NO
        ,REF_BNO
        ,ORIGIN_NAME
        ,CHANGE_NAME
        ,FILE_PATH
        )
        VALUES
        (
          SEQ_FNO.NEXTVAL
         ,?
         ,?
         ,?
         ,?
        );

-- * �����Խ��� ����
-- 1. �����Խ��� �ۼ��ϱ� ��û�� ������ sql��
-- 1_1. Board���̺� insert

INSERT 
  INTO BOARD
  (
     BOARD_NO
   , BOARD_TYPE
   , BOARD_TITLE
   , BOARD_CONTENT
   , BOARD_WRITER
   , CREATE_DATE 
  )
  VALUES
  (
    SEQ_BNO.NEXTVAL
   , 2
   , ?
   , ?
   , ?
   , SYSDATE
  );


-- 1_2. ATTACHMENT ���̺� INSERT
INSERT
  INTO ATTACHMENT
  (
     FILE_NO
   , REF_BNO
   , ORIGIN_NAME
   , CHANGE_NAME
   , FILE_PATH
   , FILE_LEVEL
  )
  VALUES
  (
     SEQ_FNO.NEXTVAL 
   , SEQ_BNO.CURRVAL
   , ?
   , ?
   , ?
   , ?
  );

-- 2. �����Խ��� ����� ��ȸ�� ����� sql��

SELECT
       BOARD_NO
     , BOARD_TITLE
     , COUNT
     , FILE_PATH || CHANGE_NAME "TITLEiMG"
 FROM BOARD B
 JOIN ATTACHMENT ON(BOARD_NO = REF_BNO)
WHERE BOARD_TYPE = 2
  AND FILE_LEVEL = 1
  AND B.STATUS = 'Y'
ORDER BY BOARD_NO DESC;

-- [AJAX] ��� �ۼ� ��û�� ������ SQL��

INSERT
  INTO REPLY
  (
     REPLY_NO
   , REPLY_CONTENT
   , REF_BNO
   , REPLY_WRITER
   , CREATE_DATE
   )
   VALUES
   (
      SEQ_RNO.NEXTVAL
    , '�������� ��õ��'
    , 115
    , 1
    , SYSDATE
   );

commit;

-- [ALAX] �ش� �Խñۿ� �����ִ� ��� ��ȸ sql��

SELECT
        REPLY_NO
      , REPLY_CONTENT
      , USER_ID
      , CREATE_DATE
 FROM   REPLY
 JOIN MEMBER ON(REPLY_WRITER = USER_NO)
      



