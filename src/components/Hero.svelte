<script>
</script>

<div class="base-container">
  <!-- Image fürs Handy -->
  <div class="img-container">
    <img class="img" src="images/1.jpeg" alt="Prince" />
  </div>

  <!-- Image für Bildschirm -->
  <div class="base-images">
    <div class="images up">
      <img class="img-item" src="images/6.jpeg" alt="" />
    </div>

    <div class="images middle">
      <img class="img-item" src="images/2.jpeg" alt="" />
    </div>

    <div class="images down">
      <img class="img-item" src="images/1.jpeg" alt="" />
    </div>
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
  .images {
    display: none;
  }
  @media only screen and (min-width: 1024px) {
    .images {
      display: block;
    }
    .img-item {
      box-shadow: rgba(255, 255, 255, 0.1) 0px 1px 1px 0px inset,
        rgba(50, 50, 93, 0.25) 0px 50px 100px -20px,
        rgba(0, 0, 0, 0.3) 0px 30px 60px -30px;
      border-radius: 5%;
    }
    .down {
      width: 50%;
      z-index: 1;
    }
    .middle {
      position: absolute;
      top: 15%;
      left: 25%;
      width: 30%;
      z-index: 2;
    }
    .up {
      position: absolute;
      top: 30%;
      left: 9%;
      width: 27%;
      z-index: 3;
    }
    .img-container {
      display: none;
    }
  }
  .info-container {
    padding-top: 5rem;
  }

  @media only screen and (min-width: 1024px) {
    .base-container {
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 4rem 2rem 6rem;
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
