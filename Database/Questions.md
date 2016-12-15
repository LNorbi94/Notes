- Írja le az UNDO naplózás szabályait és a lemezre írások sorrendjét.
 - naplóbejegyzések kiírása lemezre.
 - módosított elemek kiírása lemezre.
 - COMMIT naplóbejegyzés kiírása lemezre.
- Adja meg a helyreállítás lépéseit UNDO napló esetén.
 - A Commit-tal nem rendelkező tranzakciók hatásait fordított sorrendben (hátulról előre) 
megsemmisítjük.
 - A végén <ABORT, T>-t írunk a naplóba.
és kiírjuk lemezre a naplót.
- Adja meg az egyszerű ellenőrzőpont képzés lépéseit.
 - megvárni az aktív tranzakciók befejeződését, addig újat nem engedni, 
  majd <CKPT> írása a naplóba + FLUSH LOG.
- Adja meg a működés közbeni ellenőrzőpont képzés lépéseit UNDO napló esetén.
 - <START CKPT(T1, T2 ... Tk)> a naplóba majd FLUSH LOG.
 - megvárni az aktív tranzakciók befejeződését, közben indulhatnak újak
  majd <END CKPT> a naplóba + FLUSH LOG.
- Írja le a REDO naplózás szabályait és a lemezre írások sorrendjét.
 - naplóbejegyzések kiírása lemezre.
 - COMMIT naplóbejegyzés kiírása lemezre.
 - módosított elemek kiírása lemezre.
- Adja meg a helyreállítás lépéseit REDO napló esetén.
 - A COMMIT-tal rendelkező tranzakciók műveleteit újból végrehajtani majd <END, T>-t írni a naplóba.
 - A be nem fejezett tranzakciókra <ABORT, T>-t írni a naplóba + FLUSH LOG
- Adja meg a működés közbeni ellenőrzőpont képzés lépéseit REDO napló esetén.
 - <START CKPT(T1, T2, ... Tk)> + FLUSH LOG.
 - A START CKPT előtt befejeződött tranzakciók még lemezre nem írt módosításainak kiírása.
 - <END CKPT> + FLUSH LOG.
- Adja meg a működés közbeni ellenőrzőpont képzés lépéseit UNDO/REDO napló esetén.
 - <START CKPT(T1, T2, ... Tk)> + FLUSH LOG.
 - Az összes piszkos puffer lemezre írása.
 - <END CKPT> + FLUSH LOG.
