<script>
  import { getAuth } from "firebase/auth";
  import {
    arrayRemove,
    arrayUnion,
    collection,
    doc,
    getFirestore,
    updateDoc,
  } from "firebase/firestore";

  const fbAuth = getAuth();
  const db = getFirestore();

  export let article = {};
  let docs = [];

  let user = fbAuth.currentUser;
  let cartImage = "shopping-cart";
  const fbArticles = collection(db, "articles");

  async function addToCartHandler() {
    // Firestore-Pfad auf den richtigen Cart festlegen:
    //     db ist svelte-bulma-Firestore (vgl. z.13)
    //     users ist die collection, die wir brauchen
    //     fbAuth.currentUser.uid ist die Dokument-ID, die wir brauchen
    // Es ergibt sich also folgender Pfad "users/${fbAuth.currentUser.uid}"
    const userRef = doc(db, "users", fbAuth.currentUser.uid);

    // Update des Cart-Icons
    // wenn "filled" in cartImage tatsaechlich gefunden wird ...
    if (cartImage.indexOf("filled") >= 0) {
      // eine article.id aus dem "cart"-Array entfernen
      await updateDoc(userRef, {
        cart: arrayRemove(article.id),
      });
      // Cart-Icon updaten
      cartImage = "shopping-cart";
      console.log("Removed from Shop!");
      // cart-image sieht "leer" aus
    } else {
      // eine neue article.id in das "cart"-Array einfuegen
      await updateDoc(userRef, {
        cart: arrayUnion(article.id),
      });
      // Cart-Icon updaten
      cartImage = "shopping-cart-filled";
      console.log("added to Shop!");
    }
  }

  function addToFavoritesHandler() {
    console.log("added to Favorites!");
  }
</script>

<div class="catalog-item card">
  <div class="card-image">
    <figure class="image">
      <!-- svelte-ignore a11y-img-redundant-alt -->
      <img class="img" src="images/{article.img}" alt="article image" />
    </figure>

    <footer class="card-footer">
      {#if user !== null}
        <!-- svelte-ignore a11y-missing-attribute -->
        <a class="card-footer-item" on:click={() => addToCartHandler()}>
          <img
            class="cart-img"
            src="../public/images/{cartImage}.png"
            alt="shopping-cart"
          />
        </a>
        <!-- svelte-ignore a11y-missing-attribute -->
        <a class="card-footer-item" on:click={addToFavoritesHandler}>
          <img
            class=" fav-img"
            src="../public/images/herz-ohne.png"
            alt="fav-img"
          />
        </a>
      {:else}
        <div class="card-foot container">You should log in!</div>
      {/if}
    </footer>
  </div>
  <div class="card-content">
    <div class="media-content">
      <p class="title is-3">{article.title}</p>
    </div>
    <br />
    <div class="content">
      <p class="subtitle is-5">
        Price: {article.price} €
      </p>
    </div>
  </div>
</div>

<style>
  .image {
    position: relative;
  }
  .card-content {
    display: flex;
    align-items: center;
    flex-direction: column;
  }
  .subtitle {
    padding-top: 10px;
  }
  .card-footer-item:hover {
    cursor: pointer;
    background-color: #f6919e;
  }
  .cart-img,
  .fav-img {
    max-width: 40%;
    margin: auto;
  }
  .cart-img,
  .fav-img:hover {
    cursor: pointer;
  }
  .card-footer {
    background-color: rgb(255, 255, 255);
    border-bottom: #e7e7e7 solid 0.2px;
    bottom: 0;
    justify-content: center;
    position: absolute;
  }
  .card-foot {
    text-align: center;
    padding: 10px;
    color: rgb(248, 77, 77);
    border: solid rgb(248, 77, 77) 1.8px;
  }

  @media only screen and (min-width: 270px) {
    .is-3 {
      font-size: 1.4rem;
    }
    .is-5 {
      font-size: 1rem;
    }
  }
  @media only screen and (min-width: 570px) {
    .is-3 {
      font-size: 1.7rem;
    }
  }
</style>
