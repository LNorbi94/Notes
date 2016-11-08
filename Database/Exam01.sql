-- 2. feladat
SELECT * FROM
  (SELECT table_name, column_id, data_type FROM dba_tab_columns)
 NATURAL JOIN
  (SELECT table_name, count(column_name) ccount FROM dba_tab_columns
  WHERE upper(owner) = 'NIKOVITS'
  GROUP BY table_name)
WHERE column_id = ccount - 1 AND data_type = 'DATE';
