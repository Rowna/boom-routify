<script>
  import { redirect } from "@roxi/routify";

  import {
    getFirestore,
    doc,
    getDoc,
    updateDoc,
    deleteField,
  } from "firebase/firestore";

  import CartItem from "../components/CartItem.svelte";
  import ModalBuy from "../containers/ModalBuy.svelte";

  import { getAuth, onAuthStateChanged } from "firebase/auth";

  const db = getFirestore();
  const fbAuth = getAuth();

  let modalVisible = false;

  // Wichtig, um zu wissen ob der User null ist!
  let user = fbAuth.currentUser;
  if (user !== null) {
    console.log(`Habe die Email ${user.email}`);
  } else {
    console.log("Bin gerade nicht eingeloggt.");
  }

  // Wenn sich der Login-Status aendert ...
  onAuthStateChanged(fbAuth, (fbUser) => {
    // ... und der user ausgeloggt ist ...
    if (!fbUser) {
      $redirect("/catalog");
    }
  });

  let subtotal = 0;

  function getSubTotal(articles) {
    // Einzelpreise addieren, bevor ich ihre Summe zu subTotal addiere.
    let artPrices = 0;
    articles.forEach((el) => {
      // ist ein article aus der datenbank
      artPrices += el.price;
    });
    subtotal = Math.round((subtotal + artPrices + Number.EPSILON) * 100) / 100;
  }

  function getSubUpdate(amount) {
    // Das Problem mit den Rundungsfehlern aufheben!
    // ist die keinsmoeglich Double groesser als 1, also 1.00000
    subtotal = Math.round((subtotal + amount + Number.EPSILON) * 100) / 100;
    // subtotal += amount;
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

  // Ich glaube, die sind ähnlich user ist auch = fbAuth.currentUser
  const userDoc = doc(db, "users", user.uid);
  const userRef = doc(db, "users", fbAuth.currentUser.uid);

  /* 
   promise in Svelte ist ein reactive-Status-Variable wegen "let" und "="
   und damit kann ich in Markup mit `{#await promise}` weiterarbeiten!
   Siehe "await Block" in der Svelte.dev Dokumentation
   Das letzte Promise aus der .then()-Reihe wird in der Variable "promise"
   gespeichert und dieses gespeicherte "promise" benutzt dann
   {#await} im Markup in Svelte.
  */
  let promise = getDoc(userDoc)
    .then((snapshot) => {
      // console.log(snapshot.data().cart);
      const articles = snapshot.data().cart;
      // berechnet das aktuelle Sub-Total
      getSubTotal(articles);
      // gibt die articles fuer {#await} zurueck.
      return articles;
    })
    .catch((error) => console.error("The Error is: " + error.message));

  // Die Cart leeren.
  function clearCartHandler() {
    console.log("FieldRemove()");
    updateDoc(userRef, {
      // cart: [],
      cart: deleteField(),
    });
  }

  function executeHandler() {
    modalVisible = true;
    console.log("Gekauft!");
  }
</script>

<!-- svelte-ignore missing-declaration -->
<div class="cart">
  <div class="cart-title">
    <p>BOOM</p>
    <p class="subtitle is-7">Pay with different methods</p>
  </div>

  <div class="cart-container">
    <!-- 'promise' ist hier das letzte Promise -->
    {#await promise}
      <!-- 
        'articles' ist hier die Payload im Promise;
         wenn es keine cart-articles gibt, ist 'articles' === null.
         das testet das {#if}
      -->
    {:then articles}
      <div class="articles-container">
        {#if articles && articles.length > 0}
          <!-- svelte-ignore empty-block -->
          {#each articles as article (article.id)}
            <CartItem {article} {getSubUpdate} />
          {/each}
          <!-- Hier beginnt mit CartBox in React  -->
          <!-- Total Preis -->
          <div class="totals card">
            <div class="card-footer">
              <p class="card-footer-item title is-3 total">Subtotal:</p>
              <p class="card-footer-item title is-4">{subtotal} €</p>
            </div>

            <div class="card-footer">
              <p class="card-footer-item title is-4 is-small total">
                Shipping Costs:
              </p>
              <p class="card-footer-item title is-6">0.00 €</p>
            </div>
          </div>

          <div class="card">
            <br />
            <div class="card-footer cb-estimate-total">
              <p class="card-footer-item title is-4 total cb-total">
                Estimate Total:
              </p>
              <p class="card-footer-item title is-4">
                <code>{subtotal} €</code>
              </p>
            </div>
          </div>

          <div class="box btns-container">
            <div class="btns">
              <!-- svelte-ignore a11y-missing-attribute -->
              <a class="button is-primary cb-pay-btn" on:click={executeHandler}
                >Execute Order</a
              >
            </div>
          </div>
          <div class="box btns-container cart-btns">
            <div class="btns">
              <a
                class="button cb-delete-btn"
                on:click={clearCartHandler}
                href="/catalog">Delelte all Articles</a
              >
              <a class="button cb-gallery-btn is-primary" href="/catalog"
                >Back to Gallery</a
              >
            </div>
            <!-- Hier endet CartBox-Component in React -->

            <!-- Hier kommt das Modal -->
            {#if modalVisible}
              <ModalBuy />
            {/if}
          </div>
        {:else}
          <!-- Hier beginnt CartEmpty-Component in React -->
          <div class="box box1">
            <div>
              <p class="title is-4">
                ... The Cart is waiting for your Articles!
              </p>
            </div>
          </div>
          <div class="box box2">
            <a class="button is-primary ce-gallery-btn" href="/catalog"
              >Back to Gallery</a>
          </div>
          <!-- Hier endet CartEmpty-Component in React -->
        {/if}
      </div>
    {:catch error}
      <p style="color: red">{error.message}</p>
    {/await}
  </div>
</div>

<style>
  .totals {
    margin-bottom: 1rem;
  }
  .total {
    margin-bottom: 0;
  }
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
  }

  .btns-container {
    margin-top: 2rem;
  }
  .cart-btns {
    margin-top: 0;
  }
  .btns {
    display: flex;
    flex-direction: column;
    justify-content: center;
  }
  .cb-pay-btn,
  .cb-delete-btn {
    font-size: 1.3rem;
    margin: 5rem 0 1rem 0;
    border-radius: 10px;
    width: 100%;
    /* margin-top: 0; */
    justify-content: center;
  }
  .cb-pay-btn {
    margin-top: 1rem;
    background-color: #6acc6a;
  }
  .cb-delete-btn {
    color: rgb(134, 131, 131) !important;
    background-color: #ebf6fb !important;
    border: solid 1px rgb(199, 197, 197);
    margin-top: 1rem;
    width: 100%;
  }
  .cb-gallery-btn {
    margin-top: 1rem;
    margin-bottom: 1rem;
    background-color: #df485b !important;
    width: 100%;
    font-size: 1.3rem;
    border-radius: 10px;
    justify-content: center;
  }

  .ce-gallery-btn {
    background-color: #df485b;
    font-size: 1.3rem;
    border-radius: 10px;
    color: rgb(255, 255, 255);
    width: 70%;
    margin: 0;
    justify-content: center;
  }
  /* .box1 {
  margin-top: 5rem;
  text-align: center;
}
.box2 {
  display: flex;
  justify-content: center;
  text-align: center;
  text-decoration: none;
}
.box2:hover {
  box-shadow: none !important;
} */
</style>
