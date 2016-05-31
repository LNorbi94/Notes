Adatbázisok I.
==============

Kiterjesztett műveletek
-----------------------
- δ multihalmaz -> halmaz
- Összesítő műveletek:
-- SUM
-- AVG
-- MIN, MAX
-- COUNT

Csoportosítás
-------------
- a reláció sorainak „csoportokba” történő beosztása a reláció egy, vagy több attribútumának értékétől függően.
- γ (gamma) csoportosítási művelet kombinálja a csoportosítást és az összesítést.
- A γ alsó indexeként szereplő L elemeknek egy listája, ahol egy elem az alábbiak közül bármelyik lehet:
-- R reláció egy attribútuma, amelyre csoportosítást végzünk. Ezt nevezzük csoportosítási attribútumnak.
-- A reláció valamely attribútumára vonatkozó összesítési művelet. A kiindulásul szolgáló attribútumot összesítési attribútumnak nevezzük.
- Működése:
- Osszuk R sorait csoportokba.
- Egy csoport azokat a sorokat tartalmazza, amelyeknek az L listán szereplő csoportosítási attribútumokhoz tartozó értékei megegyeznek.
- Ha nincs csoportosítási attribútum, akkor az egész R reláció egy csoportot képez.
- Minden csoporthoz hozzunk létre olyan sort, amelyik tartalmazza:
-- A szóban forgó csoport csoportosítási attribútumait.
-- Az L lista összesítési attribútumaira vonatkozó összesítéseket.

Rendezés
--------
- τ – rendezési művelet, egy relációt a sorainak egy vagy több attribútumtól függő rendezett listájává alakít.
- τ$_{L}$(F) (L = A$_{1}$, A$_{2}$, …, A$_{n}$) – F-t először A$_{1}$, majd A$_{2}$, majd … A$_{n}$ szerint rendezi.

Külső összekapcsolások
----------------------
- FULL - Az SQL-ben a szabványos külső összekapcsolást, amely a mindkét kapcsolandó táblából származó nem kapcsolható sorokat is tartalmazza, teljes külső összekapcsolásnak nevezi.
- LEFT - Csak bal oldaliból.
- RIGHT
- Azaz a "lógó" sorokat ahelyett hogy elvetné, feltölti NULL értékkel.

SQL WITH RECURSIVE utasítás
--------------------------------------------------
> Tegyük fel, hogy a Jaratok(legitarsasag, honnan, hova, koltseg) táblában repülőjáratok adatait tároljuk, hogy melyik városból (honnan) melyik városba (hova) van közvetlen járat. Fejezzük ki SQL WITH RECURSIVE utasítással az Eljut(honnan, hova, koltseg)  átmeneti táblát, és adjuk meg hova tudunk eljutni 'Budapest'-ről legfeljebb 5000 költségből.
```SQL
WITH RECURSIVE Eljut AS 
  (SELECT honnan, hova FROM Jaratok
    UNION 
  SELECT Eljut.honnan, Jaratok.hova 
    FROM Eljut, Jaratok 
    WHERE Eljut.hova = Jaratok.honnan)
  SELECT hova 
    FROM Eljut 
    WHERE honnan = 'Bp' AND koltseg <= 5000;
```

Tranzakciók ACID tulajdonságai
---------------------------------------------
- **Atomosság (atomicity):** A tranzakció a feldolgozás atomi egysége; vagy teljes egészében végrehajtódik, vagy egyáltalán nem.
- **Konzisztenciamegőrzés (consistency):** a tranzakció futása után konzisztens legyen az adatbázis, megszorításokkal, triggerekkel biztosítjuk.
- Elkülönítés (isolation): párhuzamos végrehajtás eredménye egymás utáni végrehajtással egyezzen meg.
- Tartósság vagy állandóság (durability): a befejezett tranzakció eredménye rendszerhiba esetén sem veszhet el.

Egyedhalmaz sémája és előfordulása?
---------------------------------------------------------------------
- E(A1, .., An) egyedhalmaz
- séma:
 -- E az egyedhalmaz neve,
 -- A1, ..., An tulajdonságok,
 -- DOM(Ai) – lehetséges értékek halmaza. például: tanár(név, tanszék).
- előfordulása:
-- A konkrét egyedekből áll
-- E = {e1, ..., em} egyedek (entitások) halmaza, ahol
-- ei(k) ∈ DOM(Ak),
-- semelyik két egyed sem egyezik meg minden attribútumban (léteznek és megkülönböztethetők)

Erős és gyenge egyedhalmaz. E/K diagramban.
----------------------------------------------------------------
- Gyenge: dupla téglalap
- Erős: téglalap
- Gyenge egyedhalmazok: Az egyedhalmazok kulcsában szereplő attribútumok közül néhány, vagy esetleg az összes, más egyedhalmaznak az attribútumai. Emiatt nem tudjuk egyértelműen meghatározni, csak a kapcsolatokkal.
- Erős: Amelyet egyértelműen tudunk azonosítani. Van azonosító jellegű tulajdonsága.

Bináris kapcsolatok
-----------
- K(E1, E2)
- sok-egy: K előfordulásaiban minden E1 beli egyedhez legfeljebb 1 E2 beli egyed tartozhat.
- sok-sok: minden E1 beli egyedhez több E2 beli egyed tartozhat, és fordítva, minden E2 beli egyedhez több E1 beli egyed tartozhat.
- sok-egy: minden E1 beli egyedhez legfeljebb egy E2 beli egyed tartozhat, és fordítva, minden E2 beli egyedhez legfeljebb egy E1 beli egyed tartozhat.
![E-K](http://tanulnijo.uw.hu/adatbazis/ab_kepek/tobb_tobb_kapcs_pl.jpg)

Alosztályok és az osztályhierarchia
-----------------------------------
- K(E1, E2)
- is-a: az összes E1 beli egyed szerepel (speciális egy-egy)
- jelölése: háromszögben "isa" a kettő között

Az E/K diagram relációkká való átalakításának általános elvei.
--------------------------------------------------------------
- Egyedhalmazok átírásánál vizsgáljuk meg, ha összetett típusról van szó.
- Többértékű attribútumoknál...
-- egybe vesszük az egészet
-- több sort veszünk fel egy táblába
-- külön táblát veszünk fel

| E/K modell               | Relációs adatmodell |
|:-------------------------|:--------------------|
| egyedhalmaz séma         | relációséma         |
| tulajdonságok            | attribútumok        |
| szuperkulcs              | szuperkulcs         |
| egyedhalmaz előfordulása | reláció             |
| egyed                    | sor                 |

DML
---
- INSERT INTO <reláció> VALUES ( <konkrét értékek listája> );
- vagy
- INSERT INTO <reláció> ( <alkérdés> );
- DELETE FROM <reláció> WHERE <feltétel>;
- UPDATE <reláció> SET <attribútum értékadások listája> WHERE <sorokra vonatkozó feltétel>;

Egyszerű, összetett kulcs
-------------------------
- Az egyszerű kulcs egyetlen attribútumból áll.
- Az összetett kulcsot kettő vagy több oszlop kombinációja alkotja. 

Hivatkozási épség megszorítás
-----------------------------
- REFERENCES Tábla(mező) Tábla készítésekor
- A tábla egy oszlopában ha szerepel egy érték, akkor ennek B táblában is szerepelnie kell.

Összetett kulcs példa
---------------------
``` sql
CREATE TABLE Filmek (
  cím VARCHAR(50)
  , év INT
  , hossz INT
  , stúdió VARCHAR2
  PRIMARY KEY (cím, év)
  );
```
