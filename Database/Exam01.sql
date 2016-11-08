-- 1. feladat
SELECT * FROM (SELECT partition_name, sum(bytes) sm_bytes FROM (SELECT partition_name, bytes
FROM dba_segments
NATURAL JOIN
(SELECT partition_name p, bytes
FROM dba_segments WHERE upper(segment_type) = 'TABLE SUBPARTITION')
WHERE partition_name is not null AND upper(segment_type) = 'TABLE PARTITION') GROUP BY partition_name ORDER BY sm_bytes DESC) WHERE rownum < 4;

-- 2. feladat
SELECT * FROM
  (SELECT table_name, column_id, data_type FROM dba_tab_columns)
 NATURAL JOIN
  (SELECT table_name, count(column_name) ccount FROM dba_tab_columns
  WHERE upper(owner) = 'NIKOVITS'
  GROUP BY table_name)
WHERE column_id = ccount - 1 AND data_type = 'DATE';
