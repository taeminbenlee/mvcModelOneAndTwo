DROP TABLE BBS
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_BBS;

CREATE TABLE BBS(
	--글의 작성자
	SEQ NUMBER(8) PRIMARY KEY,
	ID VARCHAR2(50) NOT NULL,
	--답변을 설정하는 요소들
	REF NUMBER(8) NOT NULL,	--부모글의 넘버 넣어주면됨
	STEP NUMBER(8) NOT NULL,	-- 
	DEPTH NUMBER(8) NOT NULL,	--댓글에 대한 댓글 여부
	--제목 내용 작성일
	TITLE VARCHAR2(200) NOT NULL,
	CONTENT VARCHAR2(4000) NOT NULL,
	WDATE DATE NOT NULL,
	-- 삭제 (답변형 게시판은 게시글을 지울경우 그에 달린 답변이 데이터베이스 오류를 일으켜서 안보이게 하는 설정을 준다.)
	DEL NUMBER(1) NOT NULL,
	READCOUNT NUMBER(8) NOT NULL
);

CREATE SEQUENCE SEQ_BBS
START WITH 1
INCREMENT BY 1;
--ID FOREIGN KEY 설정
ALTER TABLE BBS
ADD CONSTRAINT FK_BBS_ID FOREIGN KEY(ID)
REFERENCES MEMBER(ID);

SELECT * FROM BBS;

--페이징용 번호매겨주는 쿼리문
SELECT SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, DEL, READCOUNT
FROM (SELECT ROW_NUMBER()OVER(ORDER BY REF DESC, STEP ASC) AS RNUM,
	SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, DEL, READCOUNT
	FROM BBS
	ORDER BY REF DESC, STEP ASC)
WHERE RNUM >= 11 AND RNUM <= 20;




