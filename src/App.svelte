<script>
  import firebase_config from "./server/firebase_config";

  // Firebase 9
  import { initializeApp } from "firebase/app";
  // firestore-hook installieren
  import { 
    getFirestore, 
    collection,
    getDocs
   } from "firebase/firestore";


  import { Router } from "@roxi/routify";
  import { routes } from "../.routify/routes";


  // Firebase 9
  const fb = initializeApp(firebase_config);

  // firestore-Connector initialisiern
  // damit haben wir die Verbindung zu meiner Firestore-Datenbank
  // im Firebase-"svelte-bulma"-Projekt.
  const db = getFirestore();


  // Connector zur "articles"-Collecion erstellen
  const fbArticles = collection(db, "articles");

  // Artikel-"Zip"aus Firestore downloaden;
  // der Snapshot ist wie eine Zip-Datei, die ich erst entpacken muss,
  // um weite mit den Daten arbeiten zu koennen.
  // Diese Aktion ist ASYNCHRON!, deshalb muss ich mit Promises weiterarbeiten
  getDocs(fbArticles)
    .then((snapshot) => {
      // console.table(snapshot.docs);
      let theArticles = []
      snapshot.docs.forEach((doc) => {
            // die Daten aud dem Firebase-"document" , die drin stehen.
        theArticles.push({ id: doc.id, ...doc.data()})
      })
      // console.log(theArticles);
  })
  .catch(error => console.error(error));

</script>

<Router {routes} /> 

<!--  -->
<style global lang="scss">
  @import "./main.scss";
  .block {
    padding: 2rem 6rem;
  }

</style>
