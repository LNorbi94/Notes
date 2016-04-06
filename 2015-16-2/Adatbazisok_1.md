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
``` sql
SELECT N FROM SZ
MINUS
SELECT N FROM (
SELECT * FROM (SELECT N FROM SZ), (SELECT GY FROM SZ WHERE N = 'Micimackó') 
MINUS
SELECT * FROM SZ)
INTERSECT
(SELECT N FROM SZ
MINUS
SELECT N FROM (
SELECT * FROM SZ
MINUS
SELECT * FROM (SELECT N FROM SZ), (SELECT GY FROM SZ WHERE N = 'Micimackó') ));
```
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
(2.)    Adjuk meg azokat a hajóosztályokat a gyártó országok nevével együtt, amelyeknek az ágyúi legalább 16-os kaliberûek.
(3.)    Adjuk meg a Denmark Strait-csatában elsüllyedt hajók nevét.
(4.)    Adjuk meg az adatbázisban szereplõ összes hadihajó nevét. (Ne feledjük, hogy a Hajók relációban nem feltétlenül szerepel az összes hajó!)
(5.)    Melyek azok az országok, amelyeknek csatahajóik is és cirkálóhajóik is voltak?
(6.)    Melyik hajó melyik országban készült?
(7.)    Adjuk meg a Guadalcanal csatában részt vett hajók nevét, vízkiszorítását és ágyúinak a számát.
``` sql
SELECT hajónév, ágyúkszáma, vízkiszorítás
FROM hajóosztályok natural join hajók natural join kimenetelek
WHERE  csatanév='Guadalcanal';
```
(8.)    Soroljuk fel a biztosan 1943 elõtt épült hajókat!
``` sql
SELECT hajónév FROM hajók WHERE felavatva < '01/01/43'
UNION
SELECT hajónév FROM ( SELECT * FROM csaták WHERE datum < '01/01/43' ) natural join kimenetelek;
```
(9.)    Melyik csatában volt mindenféle eredmény?
``` sql
SELECT csatanév FROM kimenetelek
MINUS
(SELECT csatanév FROM (SELECT csatanév FROM kimenetelek), (SELECT eredmény FROM kimenetelek)
MINUS
SELECT csatanév, eredmény FROM kimenetelek);
```
(10.)   Melyik években avattak legalább 3 hajót?
``` sql
 SELECT DISTINCT h1.felavatva FROM
 ( SELECT * FROM hajók h1, hajók h2, hajók h3 WHERE
 h1.felavatva = h2.felavatva AND h2.felavatva = h3.felavatva AND
 h1.hajónév != h2.hajónév AND h2.hajónév != h3.hajónév AND h1.hajónév != h3.hajónév );
```
(11.)    Az 1921-es washingtoni egyezmény betiltotta a 35 000 tonnánál súlyosabb hajókat. Adjuk meg azokat a hajókat, amelyek megszegték az egyezményt.
``` sql
SELECT hajónév FROM hajók NATURAL JOIN hajóosztályok WHERE vízkiszorítás > 35000 AND felavatva > 1921;
```
> külön leszűrni gyorsabb

(12.)    Adjuk meg azokat a hajókat, amelyek "újjáéledtek", azaz egyszer már megsérültek egy csatában, de egy késõbbi csatában újra harcoltak.
``` sql
SELECT a.hajónév
FROM ( SELECT * FROM kimenetelek NATURAL JOIN csaták) a, ( SELECT * FROM kimenetelek NATURAL JOIN csaták) b
WHERE lower(a.eredmény) != 'ok' and a.dátum < b.dátum and a.hajónév = b.hajónév;
```
(13.)    Adjuk meg azokat az osztályokat, amelyekbe csak egyetlenegy hajó tartozik.
``` sql

```
(14.)    Évenkénti bontásban hány hajót avattak?
``` sql

```
(15.)    Mely hajóosztályból mikor avatták az utolsó hajót?
``` sql

```

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

2016. 04. 06.
===

Insert
---
``` sql
        INSERT INTO táblanév [(mezőlista)] 
        -> VALUES (kif. lista);
        -> lekérdezés;
```

* Ha nincs érték megadva valamelyik oszlophoz: default érték. Ha nincs default -> null.
* Ha bármi (akár null) meg van adva, akkor az lesz az értéke. (Kivéve ha constraintet sért)
* Lekérdezésnél bármit lehet, de annyi oszlopos lekérdezésnek kell lennie mint amennyit meg akarunk adni.

Update
---
``` sql
        UPDATE táblanév SET (mezőnév=érték)+ [WHERE feltétel];
```

Delete
---
``` sql
        DELETE táblanév [WHERE feltétel];
```

Drop table
---
* Commitol végrehajtás után.

