-- sz1 tábla tulajdonosa.
SELECT * FROM dba_synonyms, dba_views v
WHERE synonym_name = 'SZ1' AND view_name = 'V1' AND v.owner = table_owner;

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
CREATE DATABASE LINK ullman CONNECT TO a8uz7t IDENTIFIED BY -
USING 'ullman';

SELECT * FROM NIKOVITS.VILAG_ORSZAGAI@ullman;

SELECT * FROM NIKOVITS.FOLYOK@aramis
WHERE INSTR(orszagok, (SELECT tld FROM NIKOVITS.VILAG_ORSZAGAI WHERE INSTR(nev, 'Cseh') != 0)) != 0;

SELECT tablespace_name, count(*), sum(bytes) / 1024 / 1024 as "SIZE (MB)"
FROM dba_data_files
GROUP BY tablespace_name;

SELECT * FROM
(SELECT segment_name, bytes
FROM dba_segments WHERE owner = 'NIKOVITS'
AND segment_type = 'TABLE'
ORDER BY bytes desc)
WHERE rownum < 3;

SELECT segment_name FROM dba_extents
WHERE owner = 'NIKOVITS' AND segment_type = 'TABLE'
GROUP BY owner, segment_name, segment_type
HAVING count(distinct file_id) > 1;

SELECT f.file_name, sum(e.bytes)
FROM dba_extents e, dba_data_files f
WHERE owner = 'NIKOVITS' AND segment_type = 'TABLE' AND segment_name = 'TABLA_123'
AND f.file_id = e.file_id
GROUP BY f.file_id, f.file_name;

-- bytes: tényleges méret, dinamikusan növekszik, maxbytes-ig mehet
SELECT * FROM dba_data_files;

-- Mennyire vannak tele a táblák
SELECT f.file_name, round(sum(e.bytes) / f.bytes, 2)
FROM dba_extents e, dba_data_files f
WHERE f.file_id = e.file_id
GROUP BY f.file_id, f.file_name, f.bytes;

SELECT tablespace_name, count(*), sum(bytes)
FROM dba_temp_files
GROUP BY tablespace_name
 UNION
SELECT tablespace_name, count(*), sum(bytes)
FROM dba_data_files
GROUP BY tablespace_name;
