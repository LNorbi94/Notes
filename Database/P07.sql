-- Adjuk meg a piros cikkekre vonatkozó szállitások összmennyiségét.
-- (vagyis a szallit táblabeli mennyiségek összegét adjuk meg)
SELECT cnev, SUM(mennyiseg) Osszeg FROM Nikovits.Cikk, Nikovits.Szallit WHERE szin = 'piros' GROUP BY cnev;
-- a) Adjuk meg úgy a lekérdezést, hogy egyik táblára se használjon indexet az oracle.
SELECT /*+ FULL(c), FULL(sz) */ cnev, SUM(mennyiseg) Osszeg FROM Nikovits.Cikk c, Nikovits.Szallit sz
WHERE szin = 'piros' GROUP BY cnev;
-- b) Adjuk meg úgy a lekérdezést, hogy csak az egyik táblára használjon indexet az oracle.
SELECT /*+ INDEX(Nikovits.Cikk), FULL(Nikovits.Szallit) */ cnev, SUM(mennyiseg) Osszeg FROM Nikovits.Cikk, Nikovits.Szallit
WHERE szin = 'piros' GROUP BY cnev;
-- c) Adjuk meg úgy a lekérdezést, hogy mindkét táblára használjon indexet az oracle.
SELECT /*+ INDEX(c), INDEX(sz) */ cnev, SUM(mennyiseg) Osszeg FROM Nikovits.Cikk c, Nikovits.Szallit sz
WHERE szin = 'piros' GROUP BY cnev;
-- d) Adjuk meg úgy a lekérdezést, hogy a két táblát SORT-MERGE módszerrel kapcsolja össze.
SELECT /*+ MERGE JOIN */ cnev, SUM(mennyiseg) Osszeg FROM Nikovits.Cikk, Nikovits.Szallit
WHERE szin = 'piros' GROUP BY cnev;
-- e) Adjuk meg úgy a lekérdezést, hogy a két táblát NESTED-LOOPS módszerrel kapcsolja össze.
SELECT /*+ NESTED LOOPS */ cnev, SUM(mennyiseg) Osszeg FROM Nikovits.Cikk, Nikovits.Szallit
WHERE szin = 'piros' GROUP BY cnev;
-- f) Adjuk meg úgy a lekérdezést, hogy a két táblát HASH-JOIN módszerrel kapcsolja össze.
SELECT /*+ HASH JOIN */ cnev, SUM(mennyiseg) Osszeg FROM Nikovits.Cikk, Nikovits.Szallit
WHERE szin = 'piros' GROUP BY cnev;
-- g) Adjuk meg úgy a lekérdezést, hogy a két táblát NESTED-LOOPS módszerrel kapcsolja össze, és ne használjon indexet.
SELECT /*+ NESTED LOOPS, FULL(Nikovits.Cikk), FULL(Nikovits.Szallit) */ cnev, SUM(mennyiseg) Osszeg
FROM Nikovits.Cikk, Nikovits.Szallit WHERE szin = 'piros' GROUP BY cnev;
