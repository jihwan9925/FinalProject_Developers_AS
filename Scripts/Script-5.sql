SELECT * FROM REPLY;

SELECT * FROM MEMBER;
SELECT * FROM COMMUNITY;
DELETE FROM community WHERE community_no = 40;
SELECT * FROM COMMUNITY_FILE;
SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME ='COMMUNITY_FILE';

DELETE FROM COMMUNITY_FILE WHERE FILE_NAME = '60ec0f8f-252b-4bdd-80e0-49d1380de504.jpg';

SELECT REPLY_CONTENT, MEMBER_ID,MEMBER_NICKNAME, REPLY_LEVEL FROM REPLY LEFT JOIN MEMBER USING(MEMBER_ID) WHERE COMMUNITY_NO=26 START WITH REPLY_LEVEL=0 CONNECT BY PRIOR REPLY_NO=REPLY_REF 
 ORDER SIBLINGS BY reply_NO;