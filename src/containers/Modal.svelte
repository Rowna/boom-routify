<script>
  import { app } from "../stores/app";
  export let showModal = true;
  function closeModal() {
    /*
      // 'glob' ist ein neues Objekt, in das die aktuellen Werte von $global
      // hineinkopiert werden. Entscheidend: Es hat eine andere Speicheradresse
      // als das Datenobjekt in $global.
      global.update((glob) => {
        glob.showSignup = false;
        glob.showLogin = false;
        // dieser Rueckgabewert ersetzt das alte glob-objekt mit dem neuen glob-objekt.
        // dadurch bekommt das glob-objekt in $global eine neue Adresse, 
        // und DAS sorgt fuer das Update in $global 
        // und fuer alle "subscribing components"
        return glob;
      });
      */
    // ALTERNATIV: $global mit set() updaten. Das geht so:
    // erstelle ein neues glob-Objekt hier im Component:
    const myNewGlob = {
      showSignup: false,
      showLogin: false,
    };
    app.set(myNewGlob);
  }
</script>

<div class="mo">
  {#if showModal}
    <div class="modal-backdrop" on:click={closeModal} />
    <div class="modal-container">
      <!-- <SignUpForm oder LoginForm/> -->
      <slot name="slot-form" />
      <slot name="button" />
      <slot name="title" />
    </div>
  {/if}
</div>

<style>
  .modal-backdrop {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100vh;
    z-index: 10;
    background: rgba(0, 0, 0, 0.55);
  }
  .modal-container {
    position: absolute;
    top: 50%;
    left: 50%;
    z-index: 100;
    transform: translate(-50%, -50%);
    padding: 10px;
    border-radius: 10px;
    width: 500px;
    max-width: 500px;
    min-height: 45vh;
    text-align: center;
    color: white;
    background: #fce6e6;
    display: flex;
    flex-direction: column;
  }
</style>
