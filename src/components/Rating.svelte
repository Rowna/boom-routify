<script>
  export let rec = {};
</script>

<div class="card-footer">
  <div class="card-footer-item kunden-container">
    <div class="card-footer-item person-container title is-5">
      {rec.username}
      <br />
      <p class="stars subtitle is-4">{rec.rating}</p>
    </div>

    <div class="card-footer-item text-container subtitle is-5">
      {rec.text}
    </div>
  </div>
</div>

<style>
  .person-container {
    align-items: center;
    text-align: center;
    flex-direction: column;
    flex-grow: 2;
    margin-bottom: 0;
  }
  .text-container {
    flex-grow: 4;
    margin-top: 0 !important;
    align-items: flex-start;
  }
  .stars {
    color: rgb(182, 164, 48);
    margin-top: 10px;
  }
  .stars::after {
    content: " ★ ";
  }
  @media only screen and (min-width: 690px) {
    .kunden-container {
      flex-direction: row;
    }
  }
</style>
