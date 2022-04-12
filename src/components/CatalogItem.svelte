<script>
  export let article = {};
  // const myArtikels = [];
</script>

<!--
<div class="catalog-container card">
    <p><img src="images/{article.img}" alt="Bild">{article.img}</p>
    <p>My title: {article.title}</p>
    <p>My price: {article.price}</p>
    <p>My description: {article.desc}</p>
</div>
-->
<div class="catalog-item card">
  <div class="card-image">
    <figure class="image">
      <!-- svelte-ignore a11y-img-redundant-alt -->
      <img class="img" src="images/{article.img}" alt="article image" />
    </figure>
  </div>
  <div class="card-content">
    <div class="media-content">
      <p class="title is-4">{article.title}</p>
    </div>

    <div class="content">
      {article.desc}
    </div>
  </div>

  <footer class="card-footer">
      <p class="card-footer-item">
          <span class="cart-img">
            <img src="../public/images/shopping-cart.png" alt="cart">
          </span>
      </p>
      <p class="card-footer-item">
          <span class="fav-img">
            <img src="../public/images/herz-ohne.png" alt="cart">
          </span>
      </p>
  </footer>
</div>

<style>
  .catalog-item {
    max-width: 500px;
  }
  .image {
    max-height: 770px;
    max-width: 600px;
  }
  .img {
      height: 450px;
      width: 450px;
  }
  .card-footer-item:hover {
      cursor: pointer;
      background-color: #f6919e;
  }
  .cart-img, .fav-img {
      max-width: 40px;
  }
  .cart-img, .fav-img:hover {
      cursor: pointer;
  }
</style>
