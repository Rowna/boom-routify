<script>
</script>

<div class="base-container">
  <!-- Image -->
  <div class="img-container">
    <img class="img" src="images/1.jpeg" alt="Prince" />
  </div>

  <!-- Infos -->
  <div class="info-container">
    <h1 class="title">BOOM</h1>
    <p class="subtitle is-6">
      A Page takes you to kids Mode where you can find your kids favorite
      clothes
    </p>

    <!-- Button -->
    <button class="button is-primary">
      <a class="btn" href="/catalog">Let's shop</a>
    </button>
  </div>
</div>

<style>
  @media only screen and (min-width: 1024px) {
    .base-container {
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 2rem 6rem;
    }
    .img {
      max-width: 80%;
      border-radius: 3%;
    }
  }

  .title {
    position: relative;
    display: grid;
    grid-template-rows: 1fr 2rem;
    font-family: "Sofia";
    color: rgba(5, 5, 5, 0.7);
    text-align: end;
    width: 80%;
    font-size: 1.5rem;
    margin: 1rem 0 0 0;
  }

  .subtitle {
    position: absolute;
    width: 80%;
    left: 5%;
  }
  @media only screen and (min-width: 570px) {
    .subtitle {
      left: 10%;
      font-size: 1.5rem;
    }
  }
  @media only screen and (min-width: 1024px) {
    .title {
      width: 90%;
      font-size: 2rem;
      margin: 1rem 0 1rem 0;
    }
    .subtitle {
      position: relative;
      font-size: 1.5rem;
    }
    .is-primary {
      width: 90%;
    }
  }

  .is-primary {
    background-color: #df485b;
    font-family: "Sofia";
    font-size: 1.3rem;
    width: 100%;
    margin: 5rem 0 1rem 0;
    border-radius: 10px;
  }

  .btn {
    color: rgb(242, 242, 242);
  }
</style>
