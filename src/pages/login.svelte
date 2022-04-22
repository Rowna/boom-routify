<script>
  import { getAuth, signInWithEmailAndPassword } from "firebase/auth";
  import { redirect } from "@roxi/routify";

  const fbAuth = getAuth();
  let userInput = { emailInput: "", passWordInput: "" };
  let fbUser = {};

  function handleSubmit() {
    // email und passwort werden an firebase geschickt.
    signInWithEmailAndPassword(
      fbAuth,
      userInput.emailInput,
      userInput.passWordInput
    )
      .then((fbCredentials) => {
        fbUser = fbCredentials.user;
        // app.set({ user: fbUser });

        $redirect("/catalog");
      })
      .catch((err) => {
        console.log("Uh oh! Konnte nicht einloggen: " + err.message);
      });

    console.log("Logging in!");
  }
</script>

<div class="base-container catalog-item card">
  <!-- on:submit|preventDefault={handleSubmit} -->
  <form class="form">
    <h1 class="title-cont is-medium">BOOM | Log In</h1>
    <div class="form-container">
      <label for="email">Your E-Mail</label>
      <input
        required
        type="email"
        class="input is-rounded"
        placeholder="Your E-Mail"
        bind:value={userInput.emailInput}
      />
      <label for="password">Your Password</label>
      <input
        class="input is-rounded"
        type="password"
        placeholder="Your Password"
        bind:value={userInput.passWordInput}
      />
      <a href="/" class="password__">Password forgotten? Choose New!</a>
    </div>
    <button
      on:click={handleSubmit}
      type="submit"
      class="button is-rounded is-primary btn"
      >Log In
    </button>

  </form>
  <div class="para-contianer">
    <p class="para__title">Password forgotten?</p>
    <span class="line">|</span>
    <a class="para__title __member" href="/signup">New Member?</a>
  </div>
</div>

<style>
  .base-container {
    background-color: rgb(240, 235, 235);
    border-top-right-radius: 8%;
    border-bottom-left-radius: 10%;
    box-shadow: rgba(17, 17, 26, 0.1) 0px 8px 24px,
      rgba(17, 17, 26, 0.1) 0px 16px 56px, rgba(17, 17, 26, 0.1) 0px 24px 80px;
    padding: 2rem 2rem;
    max-height: fit-content;
    max-width: 800px;
    width: 600px;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }
  @media only screen and (max-width: 700px) {
    .base-container {
      width: 300px;
      padding: 5px 5px;
      margin: 10px;
    }
  }
  .form {
    padding: 2rem  1.5rem 0 1.5rem;
  }
  .title-cont {
    align-items: center;
    color: #000;
    font-family: "Sofia";
    font-size: 1.5rem;
    /* margin-bottom: 0; */
    position: relative;
    margin-bottom: 2.7rem;
  }
  .title-cont::after {
    position: absolute;
    content: "Hi there! Nice to have you!";
    color: #9c9898;
    width: 100%;
    font-family: "Patrick Hand";
    font-weight: normal;
    font-size: 0.9rem;
    left: 3.2rem;
    top: 36px;
  }
  .form-container {
    /* margin-top: 1.5rem; */
    margin: 3.5rem 0 2rem 0;
    text-align: left;
    color: #000;
  }
  label {
    padding-bottom: 2px !important;
    margin-top: 1.8rem;
    padding: 10px calc(calc(0.75em - 2px) + 0.375em);
  }
  .button,
  .para-contianer {
    padding: 1rem 1.5rem;
  }
  .btn {
    margin-top: 1rem;
  }
  .para-contianer {
    display: flex;
    gap: 5px;
    justify-content: flex-end;
  }
  .is-primary {
    font-family: "Sofia";
    background: #db4e61;
    color: rgb(31, 28, 28);
    width: 100%;
  }
  .para__title {
    /* margin: 0.8rem; */
    color: rgb(77, 75, 75);
    text-align: right;
    font-family: "Patrick Hand";
  }
  .para__title:hover,
  .password__:hover,
  .__member {
    cursor: pointer;
    color: #db4e61;
  }
  .__member {
    color: #df485b;
  }
  .line {
    color: rgb(31, 28, 28);
  }
  .password__ {
    padding: 1.5rem 1rem;
    color: rgb(77, 75, 75);
    font-size: 10px;
    text-decoration: underline;
  }
</style>
