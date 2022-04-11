<script>
</script>

<div class="block">
  <div class="img-container">
    <img class="imge absolute" src="images/prince1.jpeg" alt="Prince" />
  </div>

  <div class="info">
    <h1 class="info__title">BOOM</h1>
    <p>
      A Page takes you to kids Mode where you can find your
      kids favorite clothes
    </p>
    <button class="button is-primary">
        <a href="/catalog" class="btn-a">Let's shop</a>
    </button>
  </div>
</div>

<style>
  .block {
    padding: 0 0;
    margin: 2rem 6rem;
    display: flex;
    /* background-color: #fae4e4; */
    align-items: center;
    justify-content: center;
    border-radius: 15%;
    height: 100vh;
  }
  @media only screen and (max-width: 620px) {
    .block {
      margin: 0 15px;
      flex-direction: column;
    }
    .info {
      /* flex-basis: 0; */
      text-align: start;
    }
    .img-container {
      text-align: center;
    }
    .info__title,
    p {
      padding: 0;
      /* text-align: end; */
      margin: 0;
      width: 100%;
    }
  }
  
  .info__title {
    font-family: "Sofia";
    font-weight: bold;
    color: rgba(5, 5, 5, 0.7);
    text-align: end;
    width: 80%;
    font-size: 20px;
    margin-bottom: 5px;
    padding-right: 20px;
  }
  p {
    width: 80%;
    margin-bottom: 10px;
  }
  .info {
    max-width: 490px;
    position: relative;
    font-size: 14px;
    /* flex-basis: 80%; */
  }
  .imge {
    width: 100%;
    max-width: 80%;
    height: 100%;
    border-radius: 3%;
  }
  .is-primary {
    background-color: #df485b;
    font-family: "Sofia";
    font-size: 1.3rem;
    width: 75%;
    margin-top: 2rem;
    border-radius: 15px;
}
.btn-a {
      color: black;
  }
</style>

