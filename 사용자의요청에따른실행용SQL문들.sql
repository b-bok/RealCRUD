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