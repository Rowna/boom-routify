<script>
  import { collection, getFirestore, getDocs, doc } from "firebase/firestore";

  import CartItem from "../components/CartItem.svelte";
  import { getAuth } from "firebase/auth";

  const db = getFirestore();
  const fbAuth = getAuth();

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

  const fbArticles = collection(db, "articles");

  // Wichtig, um zu wissen ob der User null ist!
  let user = fbAuth.currentUser;
  if (user !== null) {
    console.log(`Habe die Email ${user.email}`);
  } else {
    console.log("Bin gerade nicht eingeloggt.");
  }

  const cartCollRef = collection(db, "users", user.uid, "cart");

  // promise in Svelte ist ein reactive-Status-Variable wegen "let" und "="
  // und damit können wir in Markup mit `{#await promise}` weiterarbeiten!
  // Siehe "await Block" in der Svelte.dev Dokumentation
  let promise = getDocs(cartCollRef)
    .then((snapshot) => {
      /*
      // Im Snapshot ist alles drin, was wir fuer eine Zeile in der
      // Cart-Tabelle brauchen. deshalb bauen wir jetzt das Cart-Array
      // neu
      */
      // console.log(snapshot);
      // return snapshot;
    })
    .catch((error) => console.error(error));
  // console.log("Ich werde ausgefuehrt, BEVOR getDocs() gestartet wird!");
</script>

<div class="base-container">
  <div class="cart-title">
    <p>BOOM</p>
    <p class="subtitle is-7">Discover Kids Gallery with Pics</p>
  </div>

  <div class="articles-container">
    <!-- Display: Grid -->
    <div class="article-items">
      <!-- <div class="article-item"> -->
      <div class="article-img">
        <img src="../images/2.jpeg" alt="article" />
      </div>

      <div class="article-info">
        <!-- vielleicht mit flex dann Wrap in div -->
        <!-- svelte-ignore a11y-missing-content -->
        <h2 class="article-title">Dress Winnter Red</h2>
        <p class="article-desc">
          Soft Dress for all ages of kids with more pretty colours blah blah
          blah
        </p>
      </div>

      <div class="article-amount">
        <p class="article-price">€ 20.00</p>
        <p class="article-qty">Qty:</p>
      </div>

      <div class="article-delete">X</div>
      <!-- </div> -->
    </div>

    <div class="btns">
      <a class="button is-success btn" href="/">Execute Order</a>
      <a class="button is-primary btn" href="/catalog">Back to Gallery</a>
    </div>
  </div>
</div>

<style>
  .base-container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 2rem 2rem;
    margin-left: 4rem;
    margin-right: 4rem;
    height: 500px;
    margin-top: 4rem;
  }
  .cart-title {
    font-family: "Sofia";
    font-size: 2.3rem;
    color: #000;
    position: relative;
    display: grid;

    grid-template-rows: 1fr 2rem;
    justify-items: center;
  }
  @media only screen and (min-width: 670px) {
    .cart-title {
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
  .btns {
    display: flex;
    flex-direction: column;
    justify-content: center;
  }
  .is-primary,
  .is-success {
    font-size: 1.3rem;
    margin: 5rem 0 1rem 0;
    border-radius: 10px;
    margin-top: 0;
  }
  .is-primary {
    background-color: #df485b;
  }

  .article-items {
    display: grid;
    gap: 1rem;
    /* grid-template-columns: repeat(4, 1fr); */
    grid-template-columns: 250px 500px 150px 1fr;
    /* text-align: center; */
    /* align-items: center; */
    margin-bottom: 1rem;
  }
  .article-img {
  }
  .article-info {
    background-color: #e5c884;
  }
  .article-amount {
    background-color: rgb(226, 242, 197);
  }
  .article-delete {
    background-color: #c92020d5;
  }
</style>
