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
      <!-- => <a href="/singleView/{article.id}"> -->
      <a href="/singleView/{article.id}">
        <img class="imge" src="images/{article.img}" alt="article" />
      </a>
    </div>

    <!-- <p>title: {article.title}</p> -->
    <div class="card-footer-item article-info">
      <div>
        <h2 class="article-title title is-4">{article.title}</h2>
      </div>
      <div>
        <p class="article-desc subtitle is-6">{article.desc}</p>
      </div>
    </div>

    <!-- <p>price: {article.price}</p> -->
    <div class="card-footer-item article-amount">
      <div class="card-header">
        <p class="card-header-title title is-4">
          Preis:
          <!-- svelte-ignore a11y-missing-attribute -->
          <!-- svelte-ignore a11y-missing-content -->
          <a class="subtitle card-header-title is-5 price-a">
            {article.price} €
          </a>
        </p>
      </div>

      <div class="card-header">
        <p class="article-qty card-header-title subtitle is-5">Qty:</p>

        <p
          class="article-qty card-header-title subtitle is-5"
          on:click={decreaseHandler}
        >
          <!-- svelte-ignore a11y-missing-attribute -->
          <a class="subtitle is-2 is-success is-outlined is-small minus-btn"
            >-</a
          >
        </p>
        <div class="card-header-title">
          <!-- svelte-ignore a11y-missing-attribute -->
          <a class="article-qty subtitle is-5 qty-a">{qty}</a>
        </div>

        <p
          class="article-qty card-header-title subtitle is-5"
          on:click={increaseHandler}
        >
          <!-- svelte-ignore a11y-missing-attribute -->
          <a class="subtitle is-2 is-success is-outlined is-small plus-btn">+</a
          >
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

<style>
  .article-qty {
    margin-bottom: 0;
  }
  .imge {
    object-position: center;
    width: 120px;
    height: 120px;
  }
  .article-info {
    flex-direction: column;
    align-items: flex-start;
    text-align: start;
    gap: 10px;
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
  .article-delete {
    margin-top: 5px;
    color: rgb(255, 255, 255);
  }
  .article-delete:hover {
    cursor: pointer;
    background-color: #f14668;
    color: rgb(255, 255, 255);
  }

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
</style>
