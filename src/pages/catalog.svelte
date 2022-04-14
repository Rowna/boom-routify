<script>
  import CatalogItem from "../components/CatalogItem.svelte";

  // firestore-hook installieren
  import { getFirestore, collection, getDocs } from "firebase/firestore";

  let docs = [];

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
      console.log("bin im Promise!");
      let theArticles = [];
      snapshot.docs.forEach((doc) => {
        // die Daten aud dem Firebase-"document" , die drin stehen.
        theArticles.push({ id: doc.id, ...doc.data() });
      });
      docs = theArticles;
      // console.log(theArticles);
    })
    .catch((error) => console.error(error));
</script>

<div class="catalog">
  <div class="catalog-title">
    <p>BOOM</p>
  </div>

  <div class="catalog-container">
    {#each docs as article (article.id)}
      <CatalogItem {article} />
    {/each}
  </div>
</div>

<style>
  .catalog {
    margin: 8rem 10rem;
  }
  .catalog-title {
    color: #000;
    font-family: "Sofia";
    font-size: 2.3rem;
    margin-bottom: 0;
    position: relative;
    margin-bottom: 3rem;

    /* top: 50%; */
    left: 100%;
    transform: translate(-50%, -50%);
  }
  .catalog-title::after {
    position: absolute;
    content: "Discover Kids Gallery with Pics";
    color: #9c9898;
    width: 100%;
    font-family: "Patrick Hand";
    font-weight: normal;
    font-size: 1.2rem;
    left: 3.2rem;
    top: 3rem;
  }
  .catalog-container {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    justify-items: center;
    row-gap: 30px;
    column-gap: 5px;
  }
  @media only screen and (max-width: 950px) {
    .catalog-container {
      flex-direction: column;
      row-gap: 10px;
      column-gap: 10px;
    }
  }
  @media only screen and (max-width: 1950px) {
    .catalog-container {
      flex-direction: column;
      row-gap: 30px;
      column-gap: 30px;
    }
  }
  @media only screen and (max-width: 800px) {
    .catalog {
      margin: 15px 15px;
    }
  }
</style>
