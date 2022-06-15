<script>
  import {
    getFirestore,
    arrayRemove,
    doc,
    updateDoc,
  } from "firebase/firestore";
  import { getAuth } from "firebase/auth";

  const db = getFirestore();
  const fbAuth = getAuth();

  /* Wichtig, um zu wissen ob der User null ist!
   let user = fbAuth.currentUser;
   if (user !== null) {
     console.log(`Habe die Email ${user.email}`);
   } else {
     console.log("Bin gerade nicht eingeloggt.");
   }
  */
  export let getSubUpdate = null;
  export let article;
  // export let promise;

  let qty = 1;

  const userRef = doc(db, "users", fbAuth.currentUser.uid);
  let cartItem = {
    id: article.id,
    title: article.title,
    desc: article.desc,
    price: article.price,
    img: article.img,
  };

  function decreaseHandler() {
    if (qty > 1) {
      qty--;
      getSubUpdate(-article.price);
    }
  }

  function increaseHandler() {
    qty++;
    getSubUpdate(article.price);
  }

  function removeArtikelHandler() {
    console.log("Article Removed!");
    updateDoc(userRef, {
      cart: arrayRemove(cartItem),
    });
  }
</script>

<div class="box card">
  <div class="card-footer card-items">
    <!-- <h2>Art-Nr: {article.id}</h2> -->
    <div class="card-footer-item article-img">
      <!--
          Wenn ich das mit Modal richtig verstanden habe, muss das so aussehen:
          Schon beim Aufruf der Einzelansicht sollte geklaert werden, 
          ob der User schon einen kommentar geschrieben hat oder nicht.

          WENN er einen geschrieben hat,
            wird der Button "Write Recommendation" deaktiviert,
            und "seine" Recommendation in der Liste bekommt einen "Edit"-Button.
          
          Dazu weiter in Zeile 56 
        -->
      <a href="/singleView/{article.id}">
        <!-- imge ist überall in alles Components gleich, wegen Scoped -->
        <img class="imge" src="images/{article.img}" alt="article" />
      </a>
    </div>

    <div class="card-footer-item article-info">
      <div>
        <h2 class="article-title title is-4">{article.title}</h2>
      </div>
      <div>
        <p class="article-desc subtitle is-6">{article.desc}</p>
      </div>
    </div>

    <div class="card-footer-item article-amount">
      
      <div class="card-header-title title is-4 amount card-header">
        Preis:
        <p class="subtitle card-header-title is-5 price-a">
          {article.price} €
        </p>
      </div>


      <div class="card-header article-qty-container">
        <p class="article-qty card-header-title subtitle is-5 ci-article-qty">
          Qty:
        </p>

        <div class="amount-cont">
          <!-- Decrease Quantity -->
          <div
            class="article-qty-minus card-header-title subtitle is-5 ci-article-qty"
            on:click={decreaseHandler}
          >
            <!-- svelte-ignore a11y-missing-attribute -->
            <img
              class="subtitle is-2 is-success is-outlined is-small minus-btn"
              src="./images/minus.png"
              alt="pic"
            />
        </div>

          <!-- Quantity ab 1 -->
          <div class="card-header-title">
            <!-- svelte-ignore a11y-missing-attribute -->
            <a class="article-qty subtitle is-5 qty-a">{qty}</a>
          </div>

          <!-- Increase Quantity -->
          <div
            class="article-qty-plus card-header-title subtitle is-5"
            on:click={increaseHandler}
          >
            <!-- svelte-ignore a11y-missing-attribute -->
            <img
              class="subtitle is-2 is-success is-outlined is-small plus-btn"
              src="./images/plus.png"
              alt="pic"
            />
        </div>
        </div>
      </div>
    </div>
  </div>

  <div class="card-footer">
    <!-- svelte-ignore a11y-missing-attribute -->
    <!-- Routing: <a> ist gleich wie <Link> in React -->
    <a 
      href="/catalog" 
      class="button card-footer-item ci-gallery-btn is-primary"
      >To Gallery
    </a>
    <a
      href="/catalog"
      on:click={removeArtikelHandler}
      class="button card-footer-item delete-btn"
    >
      Remove this Article
    </a>
  </div>
</div>

<style>
  @media only screen and (min-width: 570px) {
    .amount,
    .article-qty-container {
      flex-direction: column;
      align-items: center;
      width: 100%;
    }
    .price-container {
      align-items: center;
      width: 100%;
    }
  }

  @media only screen and (min-width: 770px) {
    .amount,
    .article-qty-container {
      flex-direction: row;
    }
  }
  .amount-cont {
    flex-direction: row;
    display: flex;
  }
  .article-qty {
    margin-bottom: 0;
  }
  .article-qty-plus {
    width: 60px;
  }
  .article-qty-minus {
    margin-bottom: 0;
    width: 60px;
  }

  .imge {
    object-position: center;
    width: 120px;
    height: 120px;
  }
  .article-info {
    flex-direction: column;
    /* align-items: flex-start; */
    text-align: center;
    gap: 10px;
  }
  @media only screen and (max-width: 690px) {
    .article-title {
      font-size: 1rem;
    }
    .article-desc {
      font-size: 12px;
    }
  }
  .card-items {
    flex-direction: column;
  }
  @media only screen and (min-width: 300px) {
    .card-items {
      flex-direction: column !important;
    }
  }
  @media only screen and (min-width: 570px) {
    .card-items {
      flex-direction: row !important;
    }
  }

  .article-amount {
    display: flex;
    /* align-items: flex-start; */
    flex-direction: column;
  }
  .delete-btn,
  .ci-gallery-btn {
    width: 50%;
    justify-content: center;
    margin: 10px;
    background-color: transparent !important;

    border: 1px solid rgb(212, 207, 207) !important;
    color: rgb(28, 26, 26) !important;
    text-decoration: none !important;
    box-shadow: rgba(123, 123, 179, 0.25) 0px 50px 100px -20px,
    rgba(0, 0, 0, 0.3) 0px 30px 60px -30px,
    rgba(87, 132, 177, 0.35) 0px -2px 6px 0px inset !important;
  }
  .delete-btn:hover {
    cursor: pointer;
    background-color: #8d4856;
    color: rgb(255, 255, 255);
  }
  .ci-gallery-btn:hover,
  .delete-btn:hover {
  border: solid 1.8px #cc0b32 !important;
  color: #cc0b32 !important;
}
  /* .ci-gallery-btn {
    background-color: #b14b60;
  } */

  .plus-btn,
  .minus-btn {
    font-weight: bold;
    font-size: 1.7rem;
    text-decoration: none;
    color: black !important;
  }
  .qty-a {
    text-decoration: none;
  }
  .price-a {
    color: rgb(130, 152, 145);
  }

/* 
  .ci-article-qty {
  margin-bottom: 0 !important;
} */
</style>
