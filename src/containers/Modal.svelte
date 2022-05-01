<script>

  let modalCSS = "modal is-active is-clipped";

  function closeModal() {
    modalCSS = "modal";
  }

  function sendHandler() {

  }

</script>

<!-- is-active muss eine "Dynamic Class" sein -->
<div class={modalCSS}>
  <div class="modal-background" on:click={closeModal} />
  />

  <div class="modal-card">
    <header class="modal-card-head">
      <p class="modal-card-title">Article Rating</p>
      <button class="delete" aria-label="close" on:click={closeModal} />
    </header>
    <section class="modal-card-body">
      <!-- Content ... -->
      <p class="subtitle is-5">
        You can write here your recension about this article:
      </p>
      <div>
        <input
          class="input is-primary"
          type="text"
          placeholder="Your Recension"
        />
      </div>
    </section>
    <footer class="modal-card-foot">
      <button class="button is-success" on:click={sendHandler}>Send it</button>
    </footer>
  </div>
</div>

<style>
</style>
