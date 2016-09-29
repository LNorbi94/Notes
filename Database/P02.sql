-- sz1 tábla tulajdonosa.
SELECT * FROM dba_synonyms, dba_views v WHERE synonym_name = 'SZ1' AND view_name = 'V1' AND v.owner = table_owner;

-- Szekvencia.
CREATE SEQUENCE S1
MINVALUE 10
MAXVALUE 100000
START WITH 10
INCREMENT BY 10;

CREATE TABLE class (
 id NUMBER(10)
, worker VARCHAR2(50)
, CONSTRAINT S1 PRIMARY KEY (id)
);

INSERT INTO class VALUES (S1.NEXTVAL, 'Józsi');
INSERT INTO class VALUES (S1.NEXTVAL, 'Dalma');
INSERT INTO class VALUES (S1.NEXTVAL, 'Alma');

UPDATE class SET id = S1.NEXTVAL WHERE worker = 'Józsi';

SELECT * FROM  class;

-- Távoli adatbázis.
CREATE DATABASE LINK ullman CONNECT TO a8uz7t IDENTIFIED BY a8uz7t
USING 'ullman';

SELECT * FROM NIKOVITS.VILAG_ORSZAGAI@ullman;


SELECT * FROM NIKOVITS.FOLYOK@aramis WHERE INSTR(orszagok, (SELECT tld FROM NIKOVITS.VILAG_ORSZAGAI WHERE INSTR(nev, 'Cseh') != 0)) != 0;
