Adatbázisok I.
==============

(1) Relációs algebra alapműveletei.
-------------------------------------------------------------------------------------
- Vetítés. Jelölése: π$_{lista_.}$(Séma).
  _(Adott relációt vetít le az alsó indexben szereplő attribútumokra (attribútumok számát csökkentik))_
<table width="100%">
<tr>
  <th> R(A, B, C) </th>
  <th></th>
  <th>
    
  π$_{A_, B}$(R(A, B, C))
    
  </th>
</tr>
<tr align="center">
  <td>
    
  | A | B | C |
  |:--|:--|:--|
  | 1 | 2 | 3 |
  | 4 | 5 | 6 |
  | 4 | 5 | 7 |
    
  </td>
  <td> => </td>
  <td>
    
  | A | B |
  |:--|:--|
  | 1 | 2 |
  | 4 | 5 |
    
  </td>
</tr>
</table>

- Kiválasztás (szűrés). Jelölése: σ$_{feltetel_.}$(Séma) := { t | t ∈ R és t kielégíti az F feltételt}
  _(Kiválasztja az argumentumban szereplő reláció azon sorait, amelyek eleget tesznek az alsó indexben szereplő feltételnek.)_
<table width="100%">
<tr>
  <th> R(A, B, C) </th>
  <th></th>
  <th>
    
  σ$_{A = 'a'_ V C = 'f'}$(R(A, B, C))
    
  </th>
</tr>
<tr align="center">
  <td>
    
  | A | B | C |
  |:--|:--|:--|
  | a | 2 | c |
  | b | 3 | h |
  | d | 4 | f |
    
  </td>
  <td> => </td>
  <td>
  
  | A | B | C |
  |:--|:--|:--|
  | a | 2 | c |
  | d | 4 | f |
    
  </td>
</tr>
</table>

- Unió.
- Különbség.
- Természetes összekapcsolás.
- Átnevezés.

(2) Unér alap relációs algebrai műveletek, kiválasztási feltétel.
-------------------------------------------------------------

(3) Ismertesse röviden több táblára vonatkozó (binér) alap relációs algebrai műveleteket!
-------------------------------------------------------------
(4) Mi a különbség a természetes összekacsolás (natural join) és a Descartes-szorzat (más néven direkt szorzat, cross join) között? Adja meg mindkettő definícióját relációs algebrában! 
-------------------------------------------------------------
(5) Adjon példát olyan relációs algebrai kifejezésre, ahol szükséges az átnevezés használata!
-------------------------------------------------------------
(6) Legyen adott a PC(azonosító, sebesség, memória, ár) sémájú reláció. Fejezze ki az alap relációs algebrában a leggyorsabb (vagyis legnagyobb sebességű) PC azonosítóját és árát!
------------------------------------------------------------- 
(7) Mi a természetes összekapcsolás relációs algebrában és hogyan fejezhető ki az SQL-ben?
-------------------------------------------------------------
(8) Halmazműveletek kifejezése relációs algebrában és SQL-ben.  
-------------------------------------------------------------
