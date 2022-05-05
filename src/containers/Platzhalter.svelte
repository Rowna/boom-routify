<script>
    let modalCSS = "modal is-active is-clipped";
  
    function closeModal() {
      modalCSS = "modal";
    }
  </script>
  
  <div class={modalCSS}>
    <div class="modal-background" on:click={closeModal} />
    />
  
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">Under Construction ..</p>
        <button class="delete" aria-label="close" on:click={closeModal} />
      </header>
      <section class="modal-card-body">
        <!-- Content ... -->
        <p class="subtitle is-5">
            This Page is Under Construction ..
        </p>
        <div />
      </section>
    </div>
  </div>
  
  <style>
  </style>