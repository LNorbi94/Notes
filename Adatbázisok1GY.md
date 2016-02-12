Adatbázisok 1. Gyakorlat
==========================

2016. 02. 10
---

(1.)  Melyek azok a gyümölcsök, amelyeket Micimackó szeret?
``` sql
SELECT GY FROM sz WHERE N = 'Micimackó';
```
(2.)  Melyek azok a gyümölcsök, amelyeket Micimackó nem szeret? (de valaki más igen)
``` sql
(SELECT DISTINCT GY FROM sz WHERE N != 'Micimackó') MINUS (SELECT DISTINCT GY FROM sz WHERE N = 'Micimackó');
```
(3.)  Kik szeretik az almát?
``` sql
SELECT N FROM sz WHERE GY = 'alma';
```
(4.)  Kik nem szeretik a körtét? (de valami mást igen)
``` sql
SELECT DISTINCT N FROM sz WHERE GY != 'körte';
```
(5.)  Kik szeretik vagy az almát vagy a körtét?
``` sql
SELECT DISTINCT N FROM sz WHERE GY = 'alma' OR GY = 'körte';
```
(6.)  Kik szeretik az almát is és a körtét is?
``` sql
(SELECT DISTINCT N FROM sz WHERE GY = 'alma') INTERSECT (SELECT DISTINCT N FROM sz WHERE GY = 'körte');
```
(7.)  Kik azok, akik szeretik az almát, de nem szeretik a körtét?
``` sql
(SELECT DISTINCT N FROM sz WHERE GY = 'alma') MINUS (SELECT DISTINCT N FROM sz WHERE GY = 'körte');
```
(8.)  Kik szeretnek legalább kétféle gyümölcsöt?
``` sql
SELECT DISTINCT sz.N FROM sz, sz sz2 WHERE sz.N = sz2.N AND sz.GY <> sz2.GY;
```
(9.)  Kik szeretnek legalább háromféle gyümölcsöt?
``` sql
SELECT DISTINCT sz.N FROM sz, sz sz2, sz sz3 WHERE sz.N = sz3.N AND sz2.N = sz3.N AND sz.N = sz2.N AND sz.GY <> sz2.GY AND sz2.GY <> sz3.GY AND sz.GY <> sz3.GY;
```
(10.) Kik szeretnek legfeljebb kétféle gyümölcsöt?
``` sql
SELECT DISTINCT sz.N FROM sz
MINUS
SELECT DISTINCT sz.N FROM sz, sz sz2, sz sz3 WHERE sz.N = sz3.N AND sz2.N = sz3.N AND sz.N = sz2.N AND sz.GY <> sz2.GY AND sz2.GY <> sz3.GY AND sz.GY <> sz3.GY;
```
(11.) Kik szeretnek pontosan kétféle gyümölcsöt?
``` sql
SELECT DISTINCT sz.N FROM sz, sz sz2 WHERE sz.N = sz2.N AND sz.GY <> sz2.GY
MINUS
SELECT DISTINCT sz.N FROM sz, sz sz2, sz sz3 WHERE sz.N = sz3.N AND sz2.N = sz3.N AND sz.N = sz2.N AND sz.GY <> sz2.GY AND sz2.GY <> sz3.GY AND sz.GY <> sz3.GY;
```
(12.) Kik szeretnek minden gyümölcsöt?
(13.) Kik azok, akik legalább azokat a gyümölcsöket szeretik, mint Micimackó?
(14.) Kik azok, akik legfeljebb azokat a gyümölcsöket szeretik, mint Micimackó?
(15.) Kik azok, akik pontosan azokat a gyümölcsöket szeretik, mint Micimackó?
16. Melyek azok a (név, név) párok, akiknek legalább egy gyümölcsben eltér 
    az ízlésük, azaz az  egyik szereti ezt a gyümölcsöt, a másik meg nem?
17. Melyek azok a (név, név) párok, akiknek pontosan ugyanaz az ízlésük, azaz 
    pontosan  ugyanazokat a gyümölcsöket szeretik? 
18. SZERET(NEV, GYUMOLCS) tábla helyett EVETT(NEV, KG) legyen a relációséma 
    és azt tartalmazza, hogy ki mennyi gyümölcsöt evett összesen. 
    Ki ette a legtöbb gyümölcsöt? 
