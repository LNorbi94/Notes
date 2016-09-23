SELECT owner
FROM dba_objects WHERE object_type = 'TABLE'
GROUP BY owner having count(*) > 40
 MINUS
SELECT owner
FROM dba_objects WHERE object_type = 'INDEX'
GROUP BY owner having count(*) < 37;

SELECT owner, table_name FROM dba_tab_columns
WHERE data_type = 'DATE'
GROUP BY owner, table_name HAVING count(*) >= 8;

DESCRIBE sh.times;

SELECT owner, table_name
FROM dba_tables WHERE upper(table_name) LIKE 'Z%';

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

set serveroutput on
call tabla_kiiro('z');
