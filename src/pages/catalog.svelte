<script>
  import CatalogItem from "../components/CatalogItem.svelte";

  // import { redirect } from "@roxi/routify";
  import axios from "axios";

  let docs = [];
  let userCart = [];

  axios
    // etwas aus dem Server auslesen/abfragen ".get()"
    .get("http://localhost:4000/getArticles")
    .then((res) => res.data)
    // die Daten aus dem Server holen
    .then((data) => {
      docs = data.articles;
      // $redirect("/catalog");
    })
    .catch((err) => {
      console.log("The Error is: " + err.response.data.message);
    });
</script>

<div class="catalog">
  <div class="catalog-title">
    <p>BOOM</p>
    <p class="subtitle is-7">Discover Kids Gallery with Pics</p>
  </div>

  <div class="catalog-container">
    <!-- Listenschleife mit {#each} in Svelte -->
    <!-- {#each docs as article (article.id) } -->
    {#each docs as article}
      <!-- 
      { article } ist als Prop für das <CatalogItem>-Component definiert, 
      um es in <CatalogItem> benutzen zu können, muss in <CatalogItem> 
      folgende Zeile stehen:
      export let article;   

      WICHTIG: Der Name des Props muss im <Catalog> und im <CatalogItem>
      absolute gleich sein!! Sonst kommen die Daten im <CatalogItem> nicht an.
    -->
      <CatalogItem {article} {userCart} />
    {/each}
  </div>
</div>

<style>
  .catalog {
    margin: 1.2rem 1.2rem;
  }
  .catalog-title {
    position: relative;
    font-family: "Sofia";
    font-size: 2.3rem;
    color: #000;
    text-align: center;
    display: grid;
    justify-items: center;

    grid-template-rows: 1fr 2rem;
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
