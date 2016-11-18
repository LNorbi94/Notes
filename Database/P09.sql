  EXPLAIN PLAN SET statement_id='ut1'  -- ut1 -> az utasításnak egyedi nevet adunk
  FOR 
SELECT /*+ FULL(c), FULL(sz) */ cnev, SUM(mennyiseg) Osszeg FROM Nikovits.Cikk c, Nikovits.Szallit sz
WHERE szin = 'piros' GROUP BY cnev;

  EXPLAIN PLAN SET statement_id='ut2'  -- ut1 -> az utasításnak egyedi nevet adunk
  FOR 
SELECT cnev, SUM(mennyiseg) Osszeg FROM Nikovits.Cikk, Nikovits.Szallit WHERE szin = 'piros' GROUP BY cnev;

  EXPLAIN PLAN SET statement_id='ut3'  -- ut1 -> az utasításnak egyedi nevet adunk
  FOR 
SELECT /*+ NESTED LOOPS */ cnev, SUM(mennyiseg) Osszeg FROM Nikovits.Cikk, Nikovits.Szallit
WHERE szin = 'piros' GROUP BY cnev;

SELECT * FROM plan_table;

SELECT SUBSTR(LPAD(' ', 2*(LEVEL-1))||operation||' + '||options||' + '||object_name, 1, 50) terv,
  cost, cardinality, bytes, io_cost, cpu_cost
FROM plan_table
START WITH ID = 0 AND STATEMENT_ID = 'ut2'                 -- az utasítás neve szerepel itt
CONNECT BY PRIOR id = parent_id AND statement_id = 'ut2'   -- meg itt
ORDER SIBLINGS BY position;

SELECT SUM(mennyiseg) FROM Nikovits.Cikk c, Nikovits.Szallit sz WHERE szin = 'piros' and c.ckod = sz.ckod;

  EXPLAIN PLAN SET statement_id='ut4'  -- ut1 -> az utasításnak egyedi nevet adunk
  FOR 
SELECT SUM(mennyiseg) FROM Nikovits.Cikk c, Nikovits.Szallit sz WHERE szin = 'piros' and c.ckod = sz.ckod;

SELECT SUBSTR(LPAD(' ', 2*(LEVEL-1))||operation||' + '||options||' + '||object_name, 1, 50) terv,
  cost, cardinality, bytes, io_cost, cpu_cost
FROM plan_table
START WITH ID = 0 AND STATEMENT_ID = 'ut4'                 -- az utasítás neve szerepel itt
CONNECT BY PRIOR id = parent_id AND statement_id = 'ut4'   -- meg itt
ORDER SIBLINGS BY position;

SELECT * FROM dba_ind_columns WHERE table_owner = 'NIKOVITS' AND table_name in ('CIKK', 'SZALLIT');

SELECT /*+ INDEX(c) INDEX(sz) */ SUM(mennyiseg) FROM Nikovits.Cikk c, Nikovits.Szallit sz WHERE szin = 'piros' and c.ckod = sz.ckod;

select sum(mennyiseg) from sh.szallit_part where ckod=1;

SELECT sum(darab) FROM nikovits.hivas, nikovits.kozpont, nikovits.primer
WHERE hivas.kozp_azon_hivo=kozpont.kozp_azon AND kozpont.primer=primer.korzet
AND primer.varos = 'Szentendre' 
AND datum + 1 = next_day(to_date('2012.01.31', 'yyyy.mm.dd'),'hétfő');

select sum(masodperc) from nikovits.hivas where datum = to_date('2012.01.31', 'yyyy.mm.dd');

select sum(masodperc) from hivas_v2 where datum = to_date('2012.01.31', 'yyyy.mm.dd');

select count(*) from nikovits.hivas_v2;

select * from dba_objects where object_type = 'TABLE' AND object_name LIKE 'HIVAS%';

-- 8. feladat
SELECT /*+ HASH JOIN */ * FROM sh.countries co, sh.customers cu where co.country_id = cu.country_id;
