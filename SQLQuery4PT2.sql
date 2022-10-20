CREATE DATABASE PROJETOUSUARIO
USE PROJETOUSUARIO
CREATE TABLE USERS(
ID			INT				IDENTITY(1,1)			NOT NULL,
NAMEE		VARCHAR(45)								NOT NULL,
USERNAME	VARCHAR(45)		  					    NOT NULL,
PASSWORDD	VARCHAR(45)		                	    NULL,
EMAIL		VARCHAR(45)								NOT NULL	
PRIMARY KEY (ID)
)
ALTER TABLE USERS
ADD CONSTRAINT USRN UNIQUE (USERNAME) 
ALTER TABLE USERS
ADD CONSTRAINT CD DEFAULT '123MUDAR' FOR PASSWORDD 

EXEC SP_HELP USERS

CREATE TABLE PROJECTS(
ID				INT			    IDENTITY(10001,1)			NOT NULL,
NAMEE			VARCHAR(45)								    NOT NULL,
DESCRIPTIONN	VARCHAR(45)						            NULL,
DATEE			DATE			CHECK(DATEE>'01-09-2014')	NOT NULL
PRIMARY KEY (ID)
)

CREATE TABLE USERS_HAS_PROJECTS(
USERS_ID		INT				NOT NULL,
PROJECTS_ID		INT				NOT NULL
PRIMARY KEY (USERS_ID, PROJECTS_ID)
FOREIGN KEY (USERS_ID)
			REFERENCES USERS (ID),
FOREIGN KEY (PROJECTS_ID)
			REFERENCES PROJECTS (ID)
)

ALTER TABLE USERS
DROP CONSTRAINT USRN 

ALTER TABLE USERS
ALTER COLUMN USERNAME	VARCHAR(10) NOT NULL

ALTER TABLE USERS
ADD CONSTRAINT USRN UNIQUE (USERNAME)
--JHJH
ALTER TABLE USERS
ALTER COLUMN PASSWORDD	VARCHAR(8) NULL

DROP TABLE USERS
DROP TABLE USERS_HAS_PROJECTS
DROP TABLE PROJECTS

INSERT INTO USERS (NAMEE,USERNAME,EMAIL)
VALUES
('MARIA','RH_MARIA','MARIA@EMPRESA.COM')
INSERT INTO USERS
VALUES
('PAULO','TI_PAULO','123@456','PAULO@EMPRESA.COM')
INSERT INTO USERS (NAMEE,USERNAME,EMAIL)
VALUES
('ANA','RH_ANA','ANA@EMPRESA.COM')
INSERT INTO USERS (NAMEE,USERNAME,EMAIL)
VALUES
('CLARA','TI_CLARA','CLARA@EMPRESA.COM')
INSERT INTO USERS
VALUES
('APARECIDO','RH_APARECI','55@!CIDO','APARECIDO@EMPRESA.COM')

SELECT * FROM USERS

INSERT INTO PROJECTS
VALUES
('RE-FOLHA','REFATORACAO DAS FOLHAS','05-09-2014'),
('MANUTENCAO PC`S','MANUTENCAO PC`S','06-09-2014'),
('AUDITORIA',NULL,'07-09-2014')

INSERT INTO USERS_HAS_PROJECTS
VALUES
(1,10001),
(5,10001),
(3,10003),
(4,10002),
(2,10002)

UPDATE PROJECTS
SET DATEE = '12-09-2014'
WHERE NAMEE = 'MANUTENCAO PC`S'

UPDATE USERS
SET USERNAME = 'RH_CIDO'
WHERE NAMEE = 'APARECIDO'

UPDATE USERS
SET PASSWORDD = '888@*'
WHERE USERNAME = 'RH_MARIA' AND PASSWORDD = '123MUDAR'

DELETE USERS_HAS_PROJECTS
WHERE USERS_ID = 2