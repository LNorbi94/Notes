7. előadás
------------------

###### Inkrementális képszintézis, kapcsolódó fogalmak, és sugárkövetéssel összehasonlítás
-------------------------------------------------------------------------------------------
- **Inkrementális képszintézis:** minden objektumra kiszámoljuk mely pixelekre képeződik le,
és ezekből csak a legközelebbit jelenítjük meg.
Gyakorlatban minden objektumot csak primitívekből építhetjük fel. Többi geometriát tesszeláljuk (primitívekkel közelítjük).
- **Koherencia:** Pixelek helyett nagyobb logikai egységet használunk, a primitíveket.
- **Pontosság:** Objektum tér pontosság.
- **Vágás:** képernyőröl kilógó elemekkel ne számoljunk feleslegesen.
- **Inkrementális elv:** az árnyalási és takarási feladatoknál felhasználjuk a nagyobb egységenként kapott információkat.

Sugárkövetés                                | Inkrementális képszintézis
--------------------------------------------|--------------------------------------------
pixelenként számol                          | primitívenként számol
amit lehet sugárral metszeni, az használható| ami nem primitív, azt azzal kell közelíteni
van tükröződés, fénytörés, vetett árnyékok  | külön algoritmus kell
takarás triviális feladat                   | külön meg kell oldani
sok pixel/sugár miatt nagy számítási igény  | koherencia miatt kissebb számítási igény

###### Grafikus szerelőszalag, bemenete, kimenete, és főbb lépései
-------------------------------------------------------------------
- **Grafikus szerelőszalag:** színterünkről készített képének műveletsorozata.
- **Bemenet:**
- Ábrázolandó tárgyak geometriai és optikai modellje.
- Virtuális kamera adatai (nézőpont, látógúla).
- Képkeret megadása (az a pixeltömb, amelyre a színterünk síkvetületét leképezzük).
- Színtérben található fényforrásokhoz és anyagokhoz tartozó megvilágítási adatok.
- **Kimenet:** kép (kétdimenziós pixeltömb, amelynek minden elemében egy színérték található)

**Főbb lépései:**
- Transzformációk (modellezési, nézeti, perspektív)
- Vágás
- Homogén osztás
- Raszterizáció és interpoláció
- Fragment feldolgozás
- Megjelenítés

###### Koordináta-rendszerek grafikus szerelőszalag kapcsán
-----------------------------------------------------------
- **Normalizált eszköz KR:** Hardverre jellemző, [-1, 1] x [-1, 1] x [-1, 1] vagy [-1, 1] x [-1, 1] x [0, 1] kiterjedésű koordináta-rendszer.
- **Képernyő KR:** Megjelenítendő képnek (ablak / képernyő) megfelelő KR. (balkezes, bal - felső sarok az origó)

###### Transzformációk grafikus szerelőszalag kapcsán
------------------------------------------------------
- Modellezési (világ) transzformáció: a saját (modell) KR-ben adott modelleket a világ KR-ben helyezi el. Tipikusan minden modellre különböző, affin transzformáció. Gyakorlatban: world / model mátrix.
- Nézeti (kamera) transzformáció: a világ KR-t a kamerához rögzített KR-be viszi át. A transzformáció a kamera tulajdonságaiból adódik (eye, center, up). Gyakorlatban: view / camera mátrix.
- Projektív transzformáció: normalizálja a látógúlát, hogy mindkét nyílásszöge π / 2 legyen.

###### Mi az origó középpontú, attól a Z tengely mentén d egységre lévő XY síkkal párhuzamos vetítési síkra vetítő középpontos vetítés mátrixa?
----------------
x   | y   | z   | .
--- |---  |---  | ---
1   | 0   | 0   | 0
0   | 1   | 0   | 0
0   | 0   | 1   | 0
0   | 0   | 1/d | 0

###### Mi a vágás, annak feladata, és mely KR-ben kell végezni?
----------------------------------------------------------------
- **Vágás:** [x, y, z]^T := [x_h / h, y_h / h, z_h / h]^T eleme [-1, 1] x [-1, 1] x [-1, 1].
Legyen h > 0, és ekkor (x, y, z) -1 és 1 között van => (hx, hy, hz) -h és h között lesz.
- **Feladata:** Azon pixelek kiszűrése, amelyek biztosan nem jelennek meg a képernyőn.
- Homogén osztás előtt kell végrehajtani az átfordulási probléma miatt.

###### Raszterizáció, tesszeláció
----------------------------------
- **Tesszeláció:** lásd fentebb.
- **Raszterizáció:** Eddig minden primitív (amiről beszéltünk) folytonos volt, azonban most már egy diszkrét térben (a képernyő képpontjain) kell dolgoznunk. Vagyis diszkretizálni kell a folytonos objektumainkat - ez a raszterizáció.

###### Algoritmus takarási feladat megoldására
-----------------------------------------------
- El kell dönteni, hogy a képernyő egyes részein milyen felületdarab látszik. Egy pont takar egy másikat, ha x és y koordinátáik megegyeznek, és a z koordinátája kissebb a másikénál.
- **Objektum tér algoritmusok:** Logikai egységenként dolgozunk, nem függ a képernyő felbontásától. Ez nem fog menni.
- **Képtér algoritmusok:** Pixelenként döntjük el, hogy mi látszik. Pl. sugárkövetés.

###### Triviális hátlapeldobás. Milyen feladatok megoldásánál alkalmazzuk?
---------------------------------------------------------------------------
- **Triviális hátlapeldobás:**
- _feltételezés:_ objektumaink zártak, azaz ha nem vagyunk az objektumban, akkor sehonnan se láthatjuk a felületét belülről.
- _körüljárási irány:_ rögzítsük, hogy az objektumainkat milyen sorrendben KELL megadnunk (CW - óramutató járásval megegyező, CCW - nem egyező).
- Ha a transzformációk után a csúcsok sorrendje nem egyezik meg a megadással, akkor hátulról látjuk => eldobhatjuk (nem kell kirajzolni).

###### Festő algoritmus. Milyen feladatoknál alkalmaztuk?
---------------------------------------------------------
- Rajzoljuk ki hátulról előre haladva a poligonokat.
- Ami közelebb van azt később rajzoljuk le => ami takarva van, az takarva lesz.
- Probléma: nem minden esetben lehet sorrendet megadni (már háromszögeknél is van ilyen eset).

###### Z-puffer eljárás
-----------------------
- Takarási feladatot pixelenként oldja meg.

1. Minden pixelre megkeresi azt a poligont, amelynek a pixelen keresztül látható pontjának Z koordinátája a legkissebb.
2. Z-bufferben eltárolja minden pixelhez a feldolgozás pillanatának megfelelően az abban látható felületi pontok közül a legkissebb Z koordinátáját.
3. A sokszögeket egyenként dolgozzuk fel, és meghatározzuk az összes olyan pixelt, ami a sokszög vetületén belül van.
4. Ha egy pixelhez érünk, kiszámoljuk a felületi pont Z koordinátáját, és összehasonlítjuk a Z-bufferben lévővel.
5. Ha az ott található érték kissebb, akkor semmi dolgunk nincs, hisz a feldolgozott objektumok között olyan van ami takarni fogja az aktuálist, ám ha nagyobb akkor ennek a színét kell beírni az aktuális pixelbe, és egyűttel a Z-bufferbe is.

###### Lokális illuminációs árnyalások
--------------------------------------
- **Saját színnel árnyalás:** Minden objektumhoz/primitívhez egy színt rendelünk, és kirajzoláskor ez lesz a pixelek értéke. Gyors, mivel ez egyetlen értékadás. Valamint borzalmas is, nem valósághű.
- **Konstans árnyalás:** megvilágítást poligononként egyszer számítjuk ki, a szín homogén a lapon belül. Gyors, a művelet a poligonok, és nem a pixelek számától függ. Olyan is előfordulhat esetlegesen hogy használható: íves részeket nem tartalmazó, diffúz, egyszinű objektumokra.
- **Goaraud árnyalás:** Megvilágítást csúcspontonként számítjuk ki, a lapon lineáris interpolációval számítjuk ki a színeket. Lassabb: N db megvilágítás számítás + minden pixelre interpoláció. Szebb: az árnyalás mínősége nagyban függ a poligonok számától, nagy lapon a csillanás nem tud megjelenni.
- **Phong árnyalás:** Csak a normálvektorokat interpoláljuk, a megvilágítást minden pixelre kiszámítjuk. Leglassabb: pixelek száma db megvilágítás számítás. Legszebb: az árnyalás mínősége nem függ a poligonok számától. Csillanás akár a poligon közepén.

###### Goaraud árnyalás, Phong árnyalás rövid leírása, összehasonlítása
-----------------------------------------------------------------------
- Ez... az előző feladat? De akkor gondolom ez külön kell.
