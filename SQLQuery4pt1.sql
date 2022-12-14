CREATE DATABASE LOCADORA
USE LOCADORA
CREATE TABLE FILME(
ID				INT									NOT NULL,
TITULO			VARCHAR(40)							NOT NULL,
ANO				INT			CHECK(ANO <= 2021)		NOT NULL
PRIMARY KEY(ID)
)

CREATE TABLE DVD(
NUM					INT											NOT NULL,
DATA_FABRICACAO		DATE	CHECK(DATA_FABRICACAO < GETDATE())	NOT NULL,
FILMEID				INT											NOT NULL
PRIMARY KEY (NUM)
FOREIGN KEY (FILMEID)
			REFERENCES FILME (ID)
)

CREATE TABLE CLIENTE(
NUM_CADASTRO		INT									NOT NULL,
NOME				VARCHAR(70)							NOT NULL,
LOGRADOURO			VARCHAR(150)						NOT NULL,
NUM					INT				CHECK(NUM >0)		NOT NULL,
CEP					CHAR(8)			CHECK(LEN(CEP)=8)	NULL
PRIMARY KEY (NUM_CADASTRO)
)

CREATE TABLE ESTRELA(
ID					INT				NOT NULL,
NOME				VARCHAR(50)		NULL
PRIMARY KEY (ID)
)

CREATE TABLE FILME_ESTRELA(
FILMEID				INT				NOT NULL,
ESTRELAID			INT				NOT NULL
PRIMARY KEY (FILMEID, ESTRELAID)
FOREIGN KEY (FILMEID)
			REFERENCES FILME (ID),
FOREIGN KEY (ESTRELAID)
			REFERENCES ESTRELA (ID)
)

CREATE TABLE LOCACAO(
DVDNUM					INT														NOT NULL,
CLIENTENUM_CADASTRO		INT														NOT NULL,
DATA_LOCACAO			DATE			DEFAULT(GETDATE())						NOT NULL,
DATA_DEVOLUCAO			DATE													NOT NULL,
VALOR					DECIMAL(7,2)	CHECK(VALOR > 0.00)						NOT NULL
PRIMARY KEY (DVDNUM, CLIENTENUM_CADASTRO, DATA_LOCACAO)
FOREIGN KEY (DVDNUM)
			REFERENCES DVD (NUM),
FOREIGN KEY (CLIENTENUM_CADASTRO)
			REFERENCES CLIENTE (NUM_CADASTRO),
CONSTRAINT DATCHECK CHECK(DATA_DEVOLUCAO > DATA_LOCACAO)
)

--DROP TABLE LOCACAO

ALTER TABLE ESTRELA
ADD NOME_REAL			VARCHAR(50)			NOT NULL

ALTER TABLE ESTRELA
ALTER COLUMN NOME_REAL	VARCHAR(50)			NULL

ALTER TABLE FILME
ALTER COLUMN	TITULO	VARCHAR(80)			NOT NULL

INSERT INTO FILME
VALUES
(1001, 'WHIPLASH', 2015),
(1002, 'BIRDMAN', 2015),
(1003, 'INTERESTELAR', 2014),
(1004, 'A CULPA ? DAS ESTRELAS', 2014),
(1005, 'ALEXANDRE E O DIA TERR?VEL, HORR?VEL, ESPANTOSO E HORROROSO', 2014),
(1006, 'SING', 2016)

INSERT INTO ESTRELA
VALUES
(9901, 'MICHAEL KEATON', 'MICHAEL JOHN DOUGLAS'),
(9902, 'EMMA STONE', 'EMILY JEAN STONE'),
(9903, 'MILES TELLER', NULL),
(9904, 'STEVE CARELL', 'STEVEN JOHN CARELL'),
(9905, 'JENNIFER GARNER', 'JENNIFER ANNE GARNER')

INSERT INTO FILME_ESTRELA
VALUES
(1002,9901),
(1002,9902),
(1001,9903),
(1005,9904),
(1005,9905)

INSERT INTO DVD
VALUES
(10001, '2020-12-02', 1001),
(10002, '2019-10-18', 1002),
(10003, '2020-04-03', 1003),
(10004, '2020-12-02', 1001),
(10005, '2019-10-18', 1004),
(10006, '2020-04-03', 1002),
(10007, '2020-12-02', 1005),
(10008, '2019-10-18', 1002),
(10009, '2020-04-03', 1003)

INSERT INTO CLIENTE
VALUES
(5501, 'MATILDE LUZ', 'RUA S?RIA', 150, '03086040'),
(5502, 'CARLOS CARREIRO', 'RUA BARTOLOMEU AIRES', 1250, '04419110'),
(5503, 'DANIEL RAMALHO', 'RUA ITAJUTIBA', 169, NULL),
(5504, 'ROBERTO BENTO', 'RUA JAYME VON ROSENBURG', 36, NULL),
(5505, 'ROSA CERQUEIRA', 'RUA ARNALDO SIM?ES PINTO', 235, '02917110')

INSERT INTO LOCACAO
VALUES
(10001, 5502, '2021-02-18', '2021-02-21', 3.50), 
(10009, 5502, '2021-02-18', '2021-02-21', 3.50),
(10002, 5503, '2021-02-18', '2021-02-19', 3.50),
(10002, 5505, '2021-02-20', '2021-02-23', 3.00),
(10004, 5505, '2021-02-20', '2021-02-23', 3.00),      
(10005, 5505, '2021-02-20', '2021-02-23', 3.00),
(10001, 5501, '2021-02-24', '2021-02-26', 3.50),
(10008, 5501, '2021-02-24', '2021-02-26', 3.50)

UPDATE CLIENTE
SET CEP = '08411150'
WHERE NUM_CADASTRO = 5503

UPDATE CLIENTE
SET CEP = '02918190'
WHERE NUM_CADASTRO = 5504

UPDATE LOCACAO
SET VALOR = 3.25
WHERE DATA_LOCACAO = '2021-02-18' AND CLIENTENUM_CADASTRO = 5502

UPDATE LOCACAO
SET VALOR = 3.10
WHERE DATA_LOCACAO = '2021-02-24' AND CLIENTENUM_CADASTRO = 5501

UPDATE DVD
SET DATA_FABRICACAO = '2019-07-14'
WHERE NUM = 10005

UPDATE ESTRELA
SET NOME_REAL = 'MILES ALEXANDER TELLER'
WHERE NOME = 'MILES TELLER'

DELETE FILME
WHERE TITULO = 'SING'


-- OP01
SELECT TITULO FROM FILME WHERE ANO = 2014
-- OP02
SELECT ID, ANO FROM FILME WHERE TITULO = 'BIRDMAN'
-- OP03
SELECT ID, ANO FROM FILME WHERE TITULO LIKE '%PLASH'
-- OP04
SELECT * FROM ESTRELA WHERE NOME LIKE 'STEVE%'

-- OP05
SELECT FILMEID,convert(char(8), DATA_FABRICACAO, 103) AS FAB FROM DVD WHERE DATA_FABRICACAO > '01-01-2020'

-- OP06
SELECT DVDNUM,DATA_LOCACAO,DATA_DEVOLUCAO, 
VALOR, CAST(VALOR + 2.00 AS DECIMAL(7,2)) AS VALOR_ACRESCIMO
FROM locacao WHERE CLIENTENUM_CADASTRO = 5505

-- OP07
SELECT LOGRADOURO, NUM, CEP FROM CLIENTE WHERE NOME = 'MATILDE LUZ'

-- OP08
SELECT NOME_REAL FROM ESTRELA WHERE NOME = 'MICHAEL KEATON'

-- OP09
SELECT NUM_CADASTRO, NOME, LOGRADOURO +' '+ CAST(NUM AS CHAR(3)) +' '+ 
CEP FROM CLIENTE WHERE NUM_CADASTRO >= 5503

--///--------------------------------------------------------------------------------------------------------
USE MASTER