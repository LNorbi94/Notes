Adatbázisok 1. Gyakorlat
==========================

2016. 02. 10
---

> Micimackó (és a gyümölcsök)

(1.)  Melyek azok a gyümölcsök, amelyeket Micimackó szeret?
``` sql
SELECT GY FROM SZ WHERE N = 'Micimackó';
```
(2.)  Melyek azok a gyümölcsök, amelyeket Micimackó nem szeret? (de valaki más igen)
(SQL szabvány szerint EXCEPT)
``` sql
SELECT GY FROM SZ
MINUS
SELECT GY FROM SZ WHERE N = 'Micimackó';
```
(3.)  Kik szeretik az almát?
``` sql
SELECT N FROM SZ WHERE GY = 'alma';
```
(4.)  Kik nem szeretik a körtét? (de valami mást igen)
``` sql
SELECT N FROM SZ
MINUS
SELECT N FROM SZ WHERE GY = 'körte';
```
(5.)  Kik szeretik vagy az almát vagy a körtét?
``` sql
SELECT DISTINCT N FROM SZ WHERE GY = 'alma' OR GY = 'körte';
```
(6.)  Kik szeretik az almát is és a körtét is?
``` sql
SELECT DISTINCT N FROM SZ WHERE GY = 'alma'
INTERSECT
SELECT DISTINCT N FROM SZ WHERE GY = 'körte';
```
(7.)  Kik azok, akik szeretik az almát, de nem szeretik a körtét?
``` sql
SELECT DISTINCT N FROM SZ WHERE GY = 'alma'
MINUS
SELECT DISTINCT N FROM SZ WHERE GY = 'körte';
```
(8.)  Kik szeretnek legalább kétféle gyümölcsöt?
``` sql
SELECT DISTINCT SZ.N FROM SZ, SZ SZ2 WHERE SZ.N = SZ2.N AND SZ.GY <> SZ2.GY;
```
(9.)  Kik szeretnek legalább háromféle gyümölcsöt?
``` sql
SELECT DISTINCT sz.N FROM sz, sz sz2, sz sz3
WHERE   sz.N = sz3.N AND sz2.N = sz3.N AND sz.N = sz2.N 
        AND sz.GY <> sz2.GY AND sz2.GY <> sz3.GY AND sz.GY <> sz3.GY;
```
(10.) Kik szeretnek legfeljebb kétféle gyümölcsöt?
``` sql
SELECT DISTINCT sz.N FROM sz
MINUS
SELECT DISTINCT sz.N FROM sz, sz sz2, sz sz3
WHERE   sz.N = sz3.N AND sz2.N = sz3.N AND sz.N = sz2.N
        AND sz.GY <> sz2.GY AND sz2.GY <> sz3.GY AND sz.GY <> sz3.GY;
```
(11.) Kik szeretnek pontosan kétféle gyümölcsöt?
``` sql
SELECT DISTINCT sz.N FROM sz, sz sz2 WHERE sz.N = sz2.N AND sz.GY <> sz2.GY
MINUS
SELECT DISTINCT sz.N FROM sz, sz sz2, sz sz3
WHERE   sz.N = sz3.N AND sz2.N = sz3.N AND sz.N = sz2.N
        AND sz.GY <> sz2.GY AND sz2.GY <> sz3.GY AND sz.GY <> sz3.GY;
```
(12.) Kik szeretnek minden gyümölcsöt?
``` sql
SELECT DISTINCT n FROM sz
MINUS
SELECT DISTINCT n FROM (SELECT * FROM (SELECT n FROM sz), (SELECT gy FROM sz) MINUS SELECT * FROM sz);
```
(13.) Kik azok, akik legalább azokat a gyümölcsöket szeretik, mint Micimackó?
(osztás)
``` sql
SELECT N FROM SZ
MINUS
SELECT N FROM (
SELECT * FROM (SELECT N FROM SZ), (SELECT GY FROM SZ WHERE N = 'Micimackó') 
MINUS
SELECT * FROM SZ);
```
(14.) Kik azok, akik legfeljebb azokat a gyümölcsöket szeretik, mint Micimackó?
``` sql
SELECT N FROM SZ
MINUS
SELECT N FROM (
SELECT * FROM SZ
MINUS
SELECT * FROM (SELECT N FROM SZ), (SELECT GY FROM SZ WHERE N = 'Micimackó') );

```
(15.) Kik azok, akik pontosan azokat a gyümölcsöket szeretik, mint Micimackó?
(13) metszet (14)
(16.) Melyek azok a (név, név) párok, akiknek legalább egy gyümölcsben eltér az ízlésük, azaz az  egyik szereti ezt a gyümölcsöt, a másik meg nem?
(17.) Melyek azok a (név, név) párok, akiknek pontosan ugyanaz az ízlésük, azaz pontosan  ugyanazokat a gyümölcsöket szeretik? 
(18.) SZERET(NEV, GYUMOLCS) tábla helyett EVETT(NEV, KG) legyen a relációséma és azt tartalmazza, hogy ki mennyi gyümölcsöt evett összesen. Ki ette a legtöbb gyümölcsöt? 
(19.) Fejezzük ki a természetes összekapcsolást a többi alapmûvelet segítségével. (A Descartes szorzatot tekintsük alapmûveletnek.)
(20.) Fejezzük ki a Descartes szorzatot a többi alapmûvelet segítségével. (A természetes összekapcsolást tekintsük alapmûveletnek.)

> Hajók.

> **Sémák:**  Hajóosztályok(osztály, típus, ország, ágyúkSzáma, kaliber, vízkiszorítás), 
>         Hajók(hajónév, osztály, felavatva), 
>         Csaták(csatanév, dátum), 
>         Kimenetelek(hajónév, csatanév, eredmény).

(1.) Melyek azok a hajók, amelyeket 1921 elõtt avattak fel?
2.    Adjuk meg azokat a hajóosztályokat a gyártó országok nevével együtt, amelyeknek az ágyúi legalább 16-os kaliberûek.
3.    Adjuk meg a Denmark Strait-csatában elsüllyedt hajók nevét.
4.    Adjuk meg az adatbázisban szereplõ összes hadihajó nevét. (Ne feledjük, hogy a Hajók relációban nem feltétlenül szerepel az összes hajó!)
5.    Melyek azok az országok, amelyeknek csatahajóik is és cirkálóhajóik is voltak?
6.    Melyik hajó melyik országban készült?
7.    Adjuk meg a Guadalcanal csatában részt vett hajók nevét, vízkiszorítását és ágyúi­nak a számát.
8.    Soroljuk fel a biztosan 1943 elõtt épült hajókat!
9.    Melyik csatában volt mindenféle eredmény?
10.   Melyik években avattak legalább 3 hajót?
11.    Az 1921-es washingtoni egyezmény betiltotta a 35 000 tonnánál súlyosabb hajókat. Adjuk meg azokat a hajókat, amelyek megszegték az egyezményt.
12.    Adjuk meg azokat a hajókat, amelyek "újjáéledtek", azaz egyszer már megsérültek egy csatában, de egy késõbbi csatában újra harcoltak.
13.    Adjuk meg azokat az osztályokat, amelyekbe csak egyetlenegy hajó tartozik.
14.    Évenkénti bontásban hány hajót avattak?
15.    Mely hajóosztályból mikor avatták az utolsó hajót?

2016. 02. 17.
---

#### R <> S (natural join) ####
---
Két tábla közül megkeresi azonos oszlopokat, és ha minden komponense megegyezik, összekapcsolja azt.

Sémája:
- Relációs Algebra esetén egymás után fűzi. pl: R(A, B, C), S(B, D) esetén (A, B, C, D) lesz.
- SQL esetén először a közöseket szedi ki, majd a többit. Fenti példa esetén ez (B, A, C, D) lesz.

#### R <>C S (théta join) ####
---
C feltétel alapján összekapcsolja a táblákat.
- Másképp: R és S szorzata, majd C feltétellel szűrés

#### Osztás ####
---
Nincs SQL-ben.
