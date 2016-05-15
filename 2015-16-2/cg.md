7. előadás
------------------

### Inkrementális képszintézis, kapcsolódó fogalmak, és sugárkövetéssel összehasonlítás ###
-------------------------------------------------------------------------------------------
- **Inkrementális képszintézis:** minden objektumra kiszámoljuk mely pixelekre képeződik le,
és ezekből csak a legközelebbit jelenítjük meg.
Gyakorlatban minden objektumot csak primitívekből építhetjük fel. Többi geometriát tesszaláljuk.
- **Koherencia:** Pixelek helyett nagyobb logikai egységet használunk, a primitíveket.
- **Pontosság:** Objektum tér pontosság.
- **Vágás:** képernyőröl kilógó elemekkl ne számoljunk feleslegesen.
- **Inkrementális elv:** az árnyalási és takarási feladatoknál felhasználjuk a nagyobb egységenként kapott információkat.

Sugárkövetés                                | Inkrementális képszintézis
--------------------------------------------|--------------------------------------------
pixelenként számol                          | primitívenként számol
amit lehet sugárral metszeni, az használható| ami nem primitív, azt azzal kell közelíteni
van tükröződés, fénytörés, vetett árnyékok  | külön algoritmus kell
takarás triviális feladat                   | külön meg kell oldani
sok pixel/sugár miatt nagy számítási igény  | koherencia miatt kissebb számítási igény

### Grafikus szerelőszalag, bemenete, kimenete, és főbb lépései ###
-------------------------------------------------------------------
- **Grafikus szerelőszalag:** színterünkről készített képének műveletsorozata.
- **Bemenet:**
- Ábrázolandó tárgyak geometriai és optikai modellje.
- Virtuális kamera adatai (nézőpont, látógúla).
- Képkeret megadása (az a pixeltömb, amelyre a színterünk síkvetületét leképezzük).
- Színtérben található fényforrásokhoz és anyagokhoz tartozó megvilágítási adatok.
- **Kimenet:** kép (kétdimenziós pixeltömb, amelynek minden elemében egy színérték található)

Főbb lépései:
- Transzformációk (modellezési, nézeti, perspektív)
- Vágás
- Homogén osztás
- Raszterizáció és interpoláció
- Fragment feldolgozás
- Megjelenítés

### Koordinátarendszerek grafikus szerelőszalag kapcsán ###
-----------------------------------------------------------
- **Első kr:**
- ****
- ****
- ****
- ****
- ****
