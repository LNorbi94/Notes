-- DBA_OBJECTS

-- Kinek a tulajdonában van a DBA_TABLES nevű nézet (illetve a DUAL nevű tábla)?
SELECT * FROM dba_objects WHERE object_name = 'DBA_TABLES' AND object_type = 'VIEW';
SELECT * FROM dba_objects WHERE object_name = 'DUAL' AND object_type = 'TABLE';

-- Kinek a tulajdonában van a DBA_TABLES nevű szinonima (illetve a DUAL nevű)?
-- (Ezért lehet őket elérni tulajdonos megadása nélkül is.)
SELECT * FROM dba_objects WHERE object_name = 'DBA_TABLES' AND object_type = 'SYNONYM';
SELECT * FROM dba_objects WHERE object_name = 'DUAL' AND object_type = 'SYNONYM';

-- Milyen típusú objektumai vannak az orauser nevű felhasználónak az adatbázisban?
SELECT DISTINCT object_type FROM dba_objects WHERE owner = 'ORAUSER';

-- Hány különböző típusú objektum van nyilvántartva az adatbázisban?
-- Melyek ezek a típusok?
SELECT COUNT(DISTINCT object_type) FROM dba_objects;
SELECT object_type, COUNT(*) FROM dba_objects GROUP BY object_type;

-- Kik azok a felhasználók, akiknek több mint 10 féle objektumuk van?
SELECT owner, COUNT(object_type) FROM dba_objects
GROUP BY owner
HAVING COUNT(object_type) > 10;

-- Kik azok a felhasználók, akiknek van triggere és nézete is?
SELECT DISTINCT owner FROM dba_objects WHERE object_type = 'TRIGGER'
INTERSECT
SELECT DISTINCT owner FROM dba_objects WHERE object_type = 'VIEW';

-- Kik azok a felhasználók, akiknek van nézete, de nincs triggere?
SELECT DISTINCT owner FROM dba_objects WHERE object_type = 'VIEW'
MINUS
SELECT DISTINCT owner FROM dba_objects WHERE object_type = 'TRIGGER';

-- Kik azok a felhasználók, akiknek több mint 40 táblájuk, de maximum 37 indexük van?
SELECT DISTINCT owner FROM dba_objects WHERE object_type = 'TABLE' GROUP BY owner HAVING COUNT(object_type) > 40
INTERSECT
SELECT DISTINCT owner FROM dba_objects WHERE object_type = 'INDEX' GROUP BY owner HAVING COUNT(object_type) <= 37;

-- Melyek azok az objektum típusok, amelyek tényleges tárolást igényelnek, vagyis tartoznak hozzájuk adatblokkok?
-- (A többinek csak a definíciója tárolódik adatszótárban)
SELECT object_type FROM dba_objects WHERE data_object_id is not null GROUP BY object_type;

-- Melyek azok az objektum típusok, amelyek nem igényelnek tényleges tárolást, vagyis nem tartoznak hozzájuk adatblokkok?
-- (Ezeknek csak a definíciója tárolódik adatszótárban)
-- Az utóbbi két lekérdezés metszete nem üres.
SELECT object_type FROM dba_objects WHERE data_object_id is null GROUP BY object_type;

----------------------------------------------------------------------------------------------------------------------------------------
-- DBA_TAB_COLUMNS

-- Hány oszlopa van a nikovits.emp táblának?
SELECT count(*) FROM dba_tab_columns WHERE table_name = 'EMP' AND owner = 'NIKOVITS';

-- Milyen típusú a nikovits.emp tábla 6. oszlopa?
SELECT data_type FROM dba_tab_columns WHERE table_name = 'EMP' AND owner = 'NIKOVITS' AND column_id = 6;

-- Adjuk meg azoknak a tábláknak a tulajdonosát és nevét, amelyeknek van 'Z' betűvel kezdődő oszlopa.
SELECT owner, table_name, column_name FROM dba_tab_columns WHERE column_name LIKE 'Z%';

-- Adjuk meg azoknak a tábláknak a nevét, amelyeknek legalább 8 darab dátum tipusú oszlopa van.
SELECT * FROM 
(SELECT DISTINCT owner, table_name, COUNT(data_type) dcount FROM dba_tab_columns
 WHERE data_type = 'DATE' GROUP BY owner, table_name, data_type)
WHERE dcount >= 8;
-- Alternatív megoldás:
SELECT owner, table_name FROM dba_tab_columns
WHERE data_type = 'DATE'
GROUP BY owner, table_name HAVING count(*) >= 8;

-- Hasznos ilyenkor:
DESCRIBE SH.TIMES;

-- Adjuk meg azoknak a tábláknak a nevét, amelyeknek 1. es 4. oszlopa is VARCHAR2 tipusú.
SELECT DISTINCT table_name FROM dba_tab_columns WHERE column_id = 1 AND data_type = 'VARCHAR2'
INTERSECT
SELECT DISTINCT table_name FROM dba_tab_columns WHERE column_id = 4 AND data_type = 'VARCHAR2';

-- Írjunk meg egy plsql procedúrát, amelyik a paraméterül kapott karakterlánc alapján kiírja azoknak
-- a tábláknak a nevét és tulajdonosát, amelyek az adott karakterlánccal kezdődnek.
CREATE OR REPLACE PROCEDURE tabla_kiiro(p_kar VARCHAR2) IS
BEGIN
   FOR v_tables IN (SELECT owner, table_name FROM dba_tab_columns WHERE table_name LIKE upper(p_kar) || '%') LOOP
   dbms_output.put_line('Tulajdonos: ' || v_tables.owner || ' , Tábla neve: ' || v_tables.table_name);
   END LOOP;
END;
/

-- Alternatív megoldás:
CREATE OR REPLACE PROCEDURE tabla_kiiro(p_kar VARCHAR2) is
  CURSOR curs1 IS SELECT owner, table_name FROM dba_tables WHERE upper(table_name) LIKE upper(p_kar) || '%';
  rec curs1%ROWTYPE;
BEGIN
  OPEN curs1;
  LOOP
    FETCH curs1 INTO rec;
    EXIT WHEN curs1%NOTFOUND;
    dbms_output.put_line(rec.owner || ' - ' || rec.table_name);
  END LOOP;
  CLOSE curs1;
END;
/

set serveroutput on;
call tabla_kiiro('z');

-- CREATE TABLE megírása
CREATE OR REPLACE PROCEDURE cr_tab(p_owner VARCHAR2, p_tabla VARCHAR2) IS
  v_out VARCHAR2(400);
BEGIN
   v_out := v_out || 'CREATE TABLE ' || p_tabla || '(';
   FOR v_table IN (SELECT * FROM dba_tab_columns WHERE owner = upper(p_owner) AND table_name = upper(p_tabla)) LOOP
     v_out := v_out || lower(v_table.column_name) || ' ' || v_table.data_type || '(' || v_table.data_length || ')';
     IF v_table.data_default IS NOT NULL THEN
      v_out := v_out || ' DEFAULT ' || v_table.data_default;
     END IF;
     v_out := v_out || ', ';
   END LOOP;
   dbms_output.put_line(RTRIM(v_out, ', ') || ');');
END;
/

call cr_tab('nikovits', 'tipus_proba');
