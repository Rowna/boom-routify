<script>
  export let article;
  export const promise = null;
</script>

<div class="box card">
  <div class="card-footer cart-items">
    <!-- <h2>Art-Nr: {article.id}</h2> -->
    <div class="card-footer-item article-img">
      <!-- svelte-ignore a11y-missing-attribute -->
      <!-- svelte-ignore a11y-missing-content -->
      <img class="imge" src="images/{article.img}" alt="article" />
    </div>

    <!-- <p>title: {article.title}</p> -->
    <div class="card-footer-item article-info">
      <h2 class="article-title title is-4">{article.title}</h2>
      <p class="article-desc subtitle is-6">{article.desc}</p>
    </div>

    <!-- <p>price: {article.price}</p> -->
    <div class="card-footer-item article-amount">
      <p class="article-price subtitle is-5">{article.price} €</p>
      <div class="card-header">
        <p class="article-qty card-header-title">Qty:</p>
      </div>
    </div>
  </div>
  <div class="card-footer">
    <p class="button card-footer-item article-delete is-dark">
      Remove this Article
    </p>
  </div>
</div>

<style>
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
