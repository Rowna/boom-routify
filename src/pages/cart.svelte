<script>
</script>

<div class="base-container">
  <div class="cart-title">
    <p>BOOM</p>
    <p class="subtitle is-7">Discover Kids Gallery with Pics</p>
  </div>

  <div class="box">
    <div class="articles">Artikels</div>
  </div>

  <div class="btns">
    <button class="button is-success">
      <a class="btn" href="/">Check the Bill</a>
    </button>

    <button class="button is-primary">
      <a class="btn" href="/catalog">Back to Gallery</a>
    </button>
  </div>
</div>

<style>
  .base-container {
    /* text-align: center; */
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 2rem 2rem;
    margin-left: 4rem;
    margin-right: 4rem;
    /* max-width: 800px; */
  }
  .box {
    height: 500px;
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
    /* align-items: center; */
    /* width: 500px; */
    /* max-width: 500px; */
    /* width: 50%; */
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
  .btn {
    color: rgb(242, 242, 242);
  }
</style>
