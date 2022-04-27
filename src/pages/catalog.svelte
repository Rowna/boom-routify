<script>
  import CatalogItem from "../components/CatalogItem.svelte";
  import { getAuth } from "firebase/auth";

  // // firestore-hook importieren
  import { collection, getDocs, getFirestore } from "firebase/firestore";

  const db = getFirestore();
  const fbAuth = getAuth();
  const user = fbAuth.currentUser;

  let docs = [];

  if (user !== null) {
    console.log(`Habe die Email ${user.email}`);
  } else {
    console.log("Bin gerade nicht eingeloggt.");
  }

  // Connector zur "articles"-Collecion erstellen mit Hilfe des
  // firestore-connectors in $app
  const fbArticles = collection(db, "articles");

  // Artikel-"Zip"aus Firestore downloaden;
  // der Snapshot ist wie eine Zip-Datei, die ich erst entpacken muss,
  // um weite mit den Daten arbeiten zu koennen.
  // Diese Aktion ist ASYNCHRON!, deshalb muss ich mit Promises weiterarbeiten
  getDocs(fbArticles)
    .then((snapshot) => {
      // console.log("bin im Promise!");
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

<!-- Notification zur Info wenn der User sich ausloggt wird rot bzw. einloggt wird orang -->
{#if user !== null}
  <div class="notification is-warning">
    <p>Bin eingeloggt als {user.email}</p>
  </div>
{:else}
  <div class="notification is-danger">
    <p>Hat mit dem Einloggen nicht geklappt!</p>
  </div>
{/if}

<div class="catalog">
  <div class="catalog-title">
    <p>BOOM</p>
    <p class="subtitle is-7">Discover Kids Gallery with Pics</p>
  </div>

  <div class="catalog-container">
    {#each docs as article (article.id)}
    <!-- 
      { article } ist als Prop für das <CatalogItem>-Component definier 
      um es in <CatalogItem> benutzen zu können, muss in <CatalogItem> 
      folgende Zeile stehen:
      export let article;   

      WICHTIG: Der Name des Props muss im <Catalog> und im <CatalogItem>
      absolute gleich sein!! Sonst kommen die Daten im <CatalogItem> nicht an.
    -->
      <CatalogItem {article} />
    {/each}
  </div>
</div>

<style>
  .catalog {
    margin: 1.2rem 1.2rem;
  }
  .catalog-title {
    font-family: "Sofia";
    font-size: 2.3rem;
    color: #000;
    text-align: center;
    display: grid;
    position: relative;

    grid-template-rows: 1fr 2rem;
    justify-items: center;
  }
  @media only screen and (min-width: 670px) {
    .catalog-title {
      position: relative;
    }
  }

  .subtitle {
    color: #9c9898;
    font-family: "Patrick Hand";
    font-size: 1rem;
    position: absolute;
    top: 50%;
    left: 50%;
  }

  /* Diese Einstellungen gelten fuer alle, auch fuer das handy!*/
  .catalog-container {
    display: grid;
    grid-template-columns: 1fr;
    justify-items: center;
    margin: 1rem 3rem;
    row-gap: 3rem;
  }
  /*  Ab 670px wird es 1fr 1fr gelten */
  @media only screen and (min-width: 670px) {
    .catalog-container {
      grid-template-columns: 1fr 1fr;
      column-gap: 2.5rem;
    }
  }
  @media only screen and (min-width: 979px) {
    .catalog-container {
      grid-template-columns: 1fr 1fr 1fr;
      gap: 1rem;
    }
  }
  @media only screen and (min-width: 1420px) {
    .catalog-container {
      grid-template-columns: 1fr 1fr 1fr 1fr;
      row-gap: 2rem;
      column-gap: 1rem;
    }
  }
  @media only screen and (min-width: 1820px) {
    .catalog-container {
      grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
      row-gap: 2rem;
      column-gap: 3rem;
    }
  }

  @media only screen and (max-width: 800px) {
    .catalog {
      margin: 15px 15px;
    }
  }
</style>
