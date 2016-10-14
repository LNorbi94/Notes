 SELECT dnev, dbms_rowid.rowid_object(ROWID) adatobj, 
        dbms_rowid.rowid_relative_fno(ROWID) fajl,
        dbms_rowid.rowid_block_number(ROWID) blokk,
        dbms_rowid.rowid_row_number(ROWID) sor
 FROM Nikovits.dolgozo;

SELECT owner, object_name, object_type FROM dba_objects WHERE data_object_id=74672;
 
SELECT ckod, cnev, rowid FROM Nikovits.cikk;
 
SELECT cnev, dbms_rowid.rowid_object(ROWID) adatobj, 
        dbms_rowid.rowid_relative_fno(ROWID) fajl,
        dbms_rowid.rowid_block_number(ROWID) blokk,
        dbms_rowid.rowid_row_number(ROWID) sor
 FROM Nikovits.cikk;
 SELECT * from dba_extents;
 
SELECT * from dba_extents WHERE object_name in (
SELECT object_name FROM dba_objects WHERE data_object_id in (
SELECT dbms_rowid.rowid_block_number(ROWID) blokk
 FROM Nikovits.cikk
)
);

SELECT * FROM dba_segments WHERE OWNER = 'NIKOVITS' AND segment_name = 'CIKK';

SELECT * from dba_extents;

SELECT owner
FROM DBA_OBJECTS WHERE object_type = 'TABLE'
GROUP BY owner having count(*) > 40;
