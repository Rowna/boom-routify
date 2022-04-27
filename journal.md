# Journal und Todo

## ToDos

* [ ] Specs fuer "Add-to-cart" Feature genau definieren
* [ ] Firestore-Dokumentation über "Daten hinzufügen" studieren
* [ ] Firestore-Dokumentation über "Daten lesen" studieren
* [ ] Das Studierte fuer die "Add-To-Cart"-Specs nutzbar machen

## Wozu Journal?

Das Journal ist ein täglicher Bericht über den Verlauf der Projektarbeit.

Jeden Tag wird -- im Idealfall -- zu Beginn der Arbeitszeit ein Tages-ToDo gesetzt: Was soll heute in diesem Projekt erledigt werden? Die Liste mit Häkchen (siehe oben) ist dabei sehr hilfreich.

In der letzten Viertelstunde des Arbeitstages kommt die Tagesbilanz:

1. Was wurde tatsächlich geschafft bzw. nicht geschafft und -- viel wichtiger !! -- woran lag das?
0. Inwiefern gab es Überraschungen (z.B. "überraschend schwierig" bzw. "überraschend einfach")?
0. Inwiefern haben sich Erwartungen erfüllt oder nicht erfüllt? ("Ich hätte nie damit gerechnet, dass ...", oder "Das und das hab ich mir wohl zu einfach gedacht. In Zukunft ...")

Die Tagesbilanz ist nicht dazu da, sich vor dem "inneren Chef" für die geleistete Arbeit zu rechtfertigen. Sie ist dazu da, ehrlich zu sich selbst zu sein, ehrlich Probleme zu benennen, damit man sie lösen kann, und sie ist da, Erfolge ehrlich und freundlich zu benennen, um die Motivation nie zu verlieren.

## Das Journal 

### 2022-04-22 17:38

#### Wie man Daten aus den emulatoren exportiert

1. Sicherstellen, dass die Emulatoren gerade laufen. Lässt sich mit einem Blick in den Browser prüfen. Ruhig noch einmal Reloaden, um sicher zu gehen.
2. in einer __NEUEN__ Shell auf der Root-Ebene des Projekts folgenden Befehl ausführen:

```powershell
 > firestore emulators:export "./fbEmulator-data"
```

Jetzt nur noch abwarten, bis firestore diesen Job beendet hat.


### 2022-04-22 17:16

Habe heute "auf die harte Tour" gelernt, dass man Server nur dann
starten darf, wenn ganz sicher ist, dass sie nicht laufen.

Ich habe offenbar den firebase-Emulator zwei Mal gestartet. Die
Folge war, dass es für alle Emulatoren nun zwei Server gab, und beide
haben auf denselben Port zugegriffen. Damit haben sie sich gegenseitig
blockiert, und nix ging mehr. In meinem Fall gab es jetzt ZWEI Auth-
Emulatoren, die beide auf Port 8888 zugreifen wollten und sich 
gegenseitig blockiert haben.

Wie macht man es in Zukunft richtig?

1. Man benutzt nur __EINE__ shell für ein und denselben Server. Immer dieselbe.
2. Man startet den firebase-Server wie folgt:

```powershell
 > firebase emulators:start --import="./fbEmulator-data"
```

3. Wenn es nötig ist, den Server neu zu starten, bricht man in der aktuellen Firebase-Shell, also da wo die Server laufen, den aktuellen Prozess __IMMER__ mit `CTRL-C` ab! Das bewirkt, dass alle Emulatoren sich selber abschalten. Man kann überprüfen, ob noch irgendwelche Emulator-Server laufen. Dafür reicht folgender Aufruf im Browser:

```
 http://localhost:4000/emulators
```

Wenn diese Seite nicht zu erreichen ist, sind alle emulatoren abgeschaltet.

4. Jetzt können die Firebase-Emulatoren problemlos neu gestartet werden (Punkt 2).

### 2022-04-19 11:00

#### Todos
* [ ] Specs fuer "Add-to-cart" Feature genau definieren
* [ ] Firestore-Dokumentation über "Daten hinzufügen" studieren

#### Vorläufiges "Add-To-Cart"-Spec


Gegeben, der User ist eingeloggt: \
Wenn der User auf den "Add-to-cart"-button klickt, \
DANN müsse d



### 2022-04-19 11:00


Beim Klicken "add-to-cart"-Button -->
    if (das ID-geklickte Artikle (aricle.id) === das ID-schon vorhandenes Artikel im Firestore ()){
        dann push bzw. add to Cart.svelte
    }