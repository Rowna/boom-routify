<script>
  import {
    getFirestore,
    doc,
    getDoc,
    updateDoc,
    deleteField,
  } from "firebase/firestore";

  import CartItem from "../components/CartItem.svelte";
  import { getAuth } from "firebase/auth";

  const db = getFirestore();
  const fbAuth = getAuth();

  // Wichtig, um zu wissen ob der User null ist!
  let user = fbAuth.currentUser;
  if (user !== null) {
    console.log(`Habe die Email ${user.email}`);
  } else {
    console.log("Bin gerade nicht eingeloggt.");
  }

  /*
    SPEC:
    Als erstes brauche ich die Artikel-IDs aus dem cart-array des aktuellen 
    eingeloggten Benutzers. das geht in folgende Abfrage:

    // eigene Variablen zum Abspeichern der Firebase-Daten
    const cartIDs = [];

    cartDoc = doc(db, "users", "cart")
    // die IDs aus Firestore herausholen. Achtung Asynchron!
    getDoc(...): Promise(payload)

    Dann brauche ich die docs aus der FB-Collection 'articles', die zu 
    diesen IDs passen.  
    .then: getDoc(): Promise(payload)

    Dann baue ich mit Hilfe dieser Artikel den Cart auf.
    .then: 

    All dies muss in einer .then()-Kette passieren, weil alles asynchron ist!
  */

  const userDoc = doc(db, "users", user.uid);
  const userRef = doc(db, "users", fbAuth.currentUser.uid);

  // promise in Svelte ist ein reactive-Status-Variable wegen "let" und "="
  // und damit können wir in Markup mit `{#await promise}` weiterarbeiten!
  // Siehe "await Block" in der Svelte.dev Dokumentation
  let promise = getDoc(userDoc)
    .then((snapshot) => {
      console.log(snapshot.data().cart);
      return snapshot.data().cart;
    })
    .catch((error) => console.error(error));

  // Die Cart leeren.
  function clearCart() {
    console.log("FieldRemove()");
    updateDoc(userRef, {
      cart: deleteField(),
    });
  }
</script>

<div class="cart">
  <div class="cart-title">
    <p>BOOM</p>
    <p class="subtitle is-7">Discover Kids Gallery with Pics</p>
  </div>

  <div class="cart-container">
    <!-- 'promise' ist hier das letzte Promise -->
    {#await promise}
      <div class="box">
        <p class="title is-4">... The Cart is waiting for your Articles!</p>
      </div>

      <!-- 'promise' ist hier die Payload im Promise -->
    {:then promise}
      <div class="articles-container">
        {#each promise as article (article.id)}
          <CartItem {article} />
        {/each}
        <div class="btns">
          <a class="button is-success" href="/">Execute Order</a>
          <a
            class="button is-danger is-light"
            on:click={clearCart}
            href="/catalog">Delelte all Articles</a
          >
          <a class="button is-primary" href="/catalog">Back to Gallery</a>
        </div>
      </div>
    {:catch error}
      <p style="color: red">{error.message}</p>
    {/await}
  </div>
</div>

<style>
  .box {
    text-align: center;
  }
  .cart {
    margin: 1.2rem 1.2rem;
  }
  .cart-title {
    position: relative;
    font-family: "Sofia";
    font-size: 2.3rem;
    color: #000;
    display: grid;
    justify-items: center;
    text-align: center;

    grid-template-rows: 1fr 2rem;
    margin: 2rem 0 2rem 0;
  }
  @media only screen and (min-width: 670px) {
    .cart-title {
      position: relative;
    }
    .cart-container {
      margin: 1rem;
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
  .articles-container {
    position: relative;
    margin: auto;
  }

  @media only screen and (min-width: 670px) {
    .cart-title,
    .articles-container {
      position: relative;
    }
  }

  @media only screen and (min-width: 1100px) {
    .cart-container {
      margin-left: 5rem;
      margin-right: 5rem;
    }
    .articles-container {
      display: flex;
      flex-direction: column;
      align-content: center;
      text-align: center;
      max-width: 1000px;
    }
    .btns {
      margin-top: 4rem;
    }
  }
  .btns {
    display: flex;
    flex-direction: column;
    justify-content: center;
  }
  .is-primary,
  .is-success,
  .is-danger {
    font-size: 1.3rem;
    margin: 5rem 0 1rem 0;
    border-radius: 10px;
    margin-top: 0;
  }
  .is-danger {
    color: rgb(134, 131, 131) !important;
    border: solid 1px rgb(199, 197, 197);
  }
  .is-primary {
    background-color: #df485b;
  }
</style>
