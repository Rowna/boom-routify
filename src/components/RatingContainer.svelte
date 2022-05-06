<script>
  import Rating from "./Rating.svelte";

  export let recommendations = [];
  //   console.log(recommendations);
</script>

<div class="card">
  <div class="card-footer-item title-container">
    <p class="title is-4">Customer Ratings:</p>
  </div>

  <div class="card">
    {#each recommendations as rec}
      <Rating {rec} />
    {/each}
  </div>
</div>

<style>
  .title-container {
    justify-content: center;
  }

</style>
