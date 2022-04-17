<script>

</script>

<div class="base-container">
  <div class="cart-title">
    <p>BOOM</p>
  </div>
  <div>Catalog</div>
  <a class="button btn is-primary" href="/catalog">Back to Gallery</a>
</div>

<style>
  .base-container {
    display: flex;
    flex-direction: column;
    padding: 2rem 2rem;
    position: absolute;
    min-width: 800px;
    width: 800px;
    top: 20%;
    left: 50%;
    transform: translate(-50%, -50%);
  }
  .cart-title {
    color: #000;
    font-family: "Sofia";
    font-size: 2.3rem;
    margin-bottom: 0;
    position: relative;
    margin-bottom: 3rem;
    /* top: 50%; */
    left: 100%;
    transform: translate(-50%, -50%);
  }
  .cart-title::after {
    position: absolute;
    content: "Select the best out of Bookmark Cart";
    color: #9c9898;
    width: 100%;
    font-family: "Patrick Hand";
    font-weight: normal;
    font-size: 1.2rem;
    left: 3.2rem;
    top: 3rem;
  }
  .btn {
    color: rgb(255, 255, 255);
    background-color: #df485b;
    font-size: 1.3rem;
  }
</style>
