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

  // Wichtig, um zu wissen ob der User null ist!
  let user = fbAuth.currentUser;
  if (user !== null) {
    console.log(`Habe die Email ${user.email}`);
  } else {
    console.log("Bin gerade nicht eingeloggt.");
  }

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

  function increaseHandler() {
    qty++;
    getSubUpdate(article.price);
  }

  function decreaseHandler() {
    if (qty > 1) {
      qty--;
      getSubUpdate(-article.price);
    }
  }

  function removeArtikelHandler() {
    console.log("Article Removed!");
    updateDoc(userRef, {
      cart: arrayRemove(cartItem),
    });
  }
</script>

<div class="box card">
  <div class="card-footer cart-items">
    <!-- <h2>Art-Nr: {article.id}</h2> -->
    <div class="card-footer-item article-img">
      <!-- svelte-ignore a11y-missing-attribute -->
      <!-- svelte-ignore a11y-missing-content -->
      <!-- svelte-ignore a11y-invalid-attribute -->
      <a href="/singleView">
        <img class="imge" src="images/{article.img}" alt="article" />
      </a>
    </div>

    <!-- <p>title: {article.title}</p> -->
    <div class="card-footer-item article-info">
      <h2 class="article-title title is-4">{article.title}</h2>
      <p class="article-desc subtitle is-6">{article.desc}</p>
    </div>

    <!-- <p>price: {article.price}</p> -->
    <div class="card-footer-item article-amount">
      <p class="article-price subtitle is-5">Preis: {article.price} €</p>
      <div class="card-header">
        <p class="article-qty card-header-title">Qty:</p>
        <p class="article-qty card-header-title">{qty}</p>
        <p class="article-qty card-header-title" on:click={decreaseHandler}>
          -
        </p>
        <p class="article-qty card-header-title" on:click={increaseHandler}>
          +
        </p>
      </div>
    </div>
  </div>
  <div class="card-footer">
    <!-- svelte-ignore a11y-missing-attribute -->
    <a
      href="/catalog"
      on:click={removeArtikelHandler}
      class="button card-footer-item article-delete is-dark"
    >
      Remove this Article
    </a>
  </div>
</div>

<!-- Total Preis -->

<!--  
<div class="totals card">
  <div class="card-footer">
    <p class="card-footer-item title is-3 total">Subtotal:</p>
    <p class="card-footer-item title is-5">60.00 €</p>
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
  <div class="card-footer">
    <p class="card-footer-item title is-4 total">Estimate Total:</p>
    <p class="card-footer-item title is-4"><code>60.00 €</code></p>
  </div>
</div>
-->
<style>
  /*  
.totals {
    margin-bottom: 1rem;
  }
  .total {
    margin-bottom: 0;
  }
  */
  .imge {
    object-position: center;
    width: 120px;
    height: 120px;
  }
  .article-info {
    flex-direction: column;
    align-items: flex-start;
  }
  @media only screen and (max-width: 790px) {
    .article-title {
      font-size: 1rem;
    }
    .article-desc {
      font-size: 12px;
    }
  }
  .article-amount {
    display: flex;
    align-items: flex-start;
    flex-direction: column;
  }
  .article-price {
    margin-bottom: 0;
  }
  .article-delete {
    margin-top: 5px;
    color: rgb(255, 255, 255);
  }
  .article-delete:hover {
    cursor: pointer;
    background-color: #f14668;
    color: rgb(255, 255, 255);
  }
</style>
