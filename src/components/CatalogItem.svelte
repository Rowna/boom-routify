<script>
  import { app } from "../stores/app";

  export let article = {};

  let cartImage = "shopping-cart";

  function addToCartHandler() {
    console.log("added to Shop!");
    // wenn "filled" in cartImage tatsaechlich gefunden wird ...
    if (cartImage.indexOf("filled") >= 0) cartImage = "shopping-cart";
    else cartImage = "shopping-cart-filled";
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
      {#if $app.user}
        <p class="card-footer-item">
          <!-- svelte-ignore a11y-missing-attribute -->
          <a class="cart-img" on:click={addToCartHandler}>
            <img src="../public/images/{cartImage}.png" alt="shopping-cart" />
          </a>
        </p>
        <p class="card-footer-item">
          <!-- svelte-ignore a11y-missing-attribute -->
          <a class="fav-img" on:click={addToFavoritesHandler}>
            <img src="../public/images/herz-ohne.png" alt="fav-img" />
          </a>
        </p>
      {:else}
        <div class="card-foot container">You should log in!</div>
        <!--  
        <p class="card-footer-item">
          <a class="cart-img">
            <img src="../public/images/shopping-cart.png" alt="shopping-cart" />
          </a>
        </p>
        <p class="card-footer-item">
          <a class="fav-img">
            <img src="../public/images/herz-ohne.png" alt="fav-img" />
          </a>
        </p>
      -->
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
    max-width: 40px;
  }
  .cart-img,
  .fav-img:hover {
    cursor: pointer;
  }
  .card-footer {
    /* margin-top: 1rem; */
    background-color: rgb(255, 255, 255);
    position: absolute;
    bottom: 0;
    width: 100%;
    border-bottom: #e7e7e7 solid 0.2px;
    border-radius: 0;
    border-top: 0;
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
