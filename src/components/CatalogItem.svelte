<script>
  import { getAuth } from "firebase/auth";
  // import singleView from "../pages/singleView/[artID].svelte";
  // import { onDestroy } from "svelte";
  import Platzhalter from "../containers/Platzhalter.svelte";

  import {
    arrayRemove,
    arrayUnion,
    doc,
    getFirestore,
    updateDoc,
  } from "firebase/firestore";

  function isInCart() {
    for (let el of userCart) {
      if (el.id === article.id) return true;  
    }
    return false;
  }

  const fbAuth = getAuth();
  const db = getFirestore();

  // "export let" bedeutet: Diese Variable ist ein "Prop".
  // Das leere Objekt ist der default-Wert, D.H. Wenn nix ankommt,
  // wird mit "article" als leerem Objekt gearbeitet.
  // "article" wird im Parent-Component "<Catalog>" deklariert
  // und mit Daten gefüllt, und das Child-Component "<CatalogItem>"
  // WARTET auf ein Prop mit dem Namen "article".
  export let article = {};
  export let userCart = [];

  let modalVisible = false;

  let user = fbAuth.currentUser;
  let cartImage = isInCart() ? "shopping-cart-filled" : "shopping-cart";
  // console.log("CartImage: " + cartImage)
  
  async function addToCartHandler() {
    // Firestore-Pfad auf den richtigen Cart festlegen:
    //     db ist svelte-bulma-Firestore (vgl. z.13)
    //     users ist die collection, die ich brauche
    //     fbAuth.currentUser.uid ist die Dokument-ID, die ich brauche
    // Es ergibt sich also folgender Pfad "users/${fbAuth.currentUser.uid}"
    const userRef = doc(db, "users", fbAuth.currentUser.uid);
    // console.log(userRef);

    // Update des Cart-Icons
    // wenn "filled" in cartImage tatsaechlich gefunden wird ...
    /*
    // ein neues Cart-Artikel-Objekt anlegen:
    */
    let cartItem = {
      id: article.id,
      title: article.title,
      desc: article.desc,
      price: article.price,
      img: article.img,
    };

    if (cartImage.indexOf("filled") >= 0) {
      // eine article.id aus dem "cart"-Array entfernen
      // const articleRef = doc(db, "users", "cart");
      // arrayRemove((articleRef), where(article.id, "=", ""))
      await updateDoc(userRef, {
        // cart: deleteField(),
        cart: arrayRemove(cartItem),
      });
      // Cart-Icon updaten
      cartImage = "shopping-cart";
      console.log("Removed from Shop!");
      // cart-image sieht "leer" aus
    } else {
      await updateDoc(userRef, {
        cart: arrayUnion(cartItem),
      });

      // Cart-Icon updaten
      cartImage = "shopping-cart-filled";
      console.log("added to Shop!");
    }
  }

  async function addToFavoritesHandler() {
    console.log("added to Favorites!");
    modalVisible = true;
  }
</script>

<div class="catalog-items card">
  <div class="card-image">
    <figure class="image">
      <!-- svelte-ignore a11y-missing-content -->
      <!-- cartSingle: ist das Einzelansicht für Recommendationssystem -->
      <!-- 
        Am Ende muss das Gelten: Der User darf nur das Artikel bewerten,
        nur wenn der User im Einzelansicht ist und auf das Bild dort klickt.
        Also href="SingleView{article.id}" brauch ich hier nicht.
      -->
      <a class="cartSingle" href="/singleView/{article.id}">
        <!-- svelte-ignore a11y-img-redundant-alt -->
        <img
          class="cartSingle img"
          src="images/{article.img}"
          alt="article image"
        />
      </a>
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
        <!-- Hier kommt das Modal -->
        {#if modalVisible}
          <Platzhalter />
        {/if}
      {:else}
        <div class="card-foot container">You should log in!</div>
      {/if}
    </footer>
  </div>
  <div class="card-content">
    <div class="media-content">
      <p class="title is-3">{article.title}</p>
    </div>

    <div>
      <p class="subtitle is-5 mc">{article.desc}</p>
    </div>

    <br />
    <div class="content">
      <p class="subtitle is-5">
        Price: <strong>{article.price}</strong> €
      </p>
    </div>
  </div>
</div>

<style>
  .cartSingle {
    background-color: #2faa22;
  }
  .cartSingle:hover {
    cursor: pointer;
  }
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
    width: 100%;
  }
  .card-foot {
    width: 100%;
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
