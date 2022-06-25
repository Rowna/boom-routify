<script>
  import { onDestroy } from "svelte/internal";
  import { UserStore } from "../stores/user";
  import axios from "axios";

  import Platzhalter from "../containers/Platzhalter.svelte";

  export let article = {};
  export let userCart = [];

  let modalVisible = false;

  function isInCart() {
    for (let el of userCart) {
      if (el.id === article._id) return true;
    }
    return false;
  }

  let myCurrentUser = null;
  // Die aktuellen Werte aus dem UserStore werden in die lokale Variable
  // myCurrentUser übertragen und UserStore wird abonniert
  const unsubscribe = UserStore.subscribe((currentUser) => {
    myCurrentUser = { ...currentUser };
  });

  // "export let" bedeutet: Diese Variable ist ein "Prop".
  // Das leere Objekt ist der default-Wert, D.H. Wenn nix ankommt,
  // wird mit "article" als leerem Objekt gearbeitet.
  // "article" wird im Parent-Component "<Catalog>" deklariert
  // und mit Daten gefüllt, und das Child-Component "<CatalogItem>"
  // WARTET auf ein Prop mit dem Namen "article".

  let cartImage = isInCart() ? "shopping-cart-filled" : "shopping-cart";
  // console.log("CartImage: " + cartImage)

  async function addToCartHandler() {
    // Update des Cart-Icons
    // wenn "filled" in cartImage tatsaechlich gefunden wird ...
    // ein neues Cart-Artikel-Objekt anlegen:

    let cartItem = {
      _id: article._id,
      title: article.title,
      desc: article.desc,
      price: article.price,
      img: article.img,
    };

    if (cartImage.indexOf("filled") >= 0) {
      axios
        .get(
          // abfragen "removeFromCart" where cartId =
          "http://localhost:4000/removeFromCart?cartId=" +
            cartItem.id +
            "&userId=" +
            myCurrentUser.userId
        )
        .then((res) => res.data)
        .then(() => {
          cartImage = "shopping-cart";
          // setCartImage("shopping-cart.png");
        })
        .catch((error) => {
          console.log("Error:" + error.message);
        });
    } else {
      axios
        .post("http://localhost:4000/addToCart", {
          // key: in body request zum server
          // value: catItem im Client Frontend
          cartItem: cartItem,
          userId: myCurrentUser.userId,
        })
        // wenn ich eine Payload vom Server zurück bekomme, geht es
        // hier weiter.
        .then((res) => res.data)
        .then(() => {
          // Cart-Icon updaten
          cartImage = "shopping-cart-filled";
        })
        .catch((error) => {
          console.log("Error:" + error.message);
        });
    }
  }

  async function addToFavoritesHandler() {
    console.log("added to Favorites!");
    modalVisible = true;
  }
  onDestroy(unsubscribe);
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
      <!-- {article._id} soll einheitlich aus Server sein -->
      <a class="cartSingle" href="/singleView/{article._id}">
        <!-- svelte-ignore a11y-img-redundant-alt -->
        <img
          class="cartSingle img"
          src="images/{article.img}"
          alt="article image"
        />
      </a>
    </figure>

    <footer class="card-footer">
      {#if myCurrentUser.token.length > 0}
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
