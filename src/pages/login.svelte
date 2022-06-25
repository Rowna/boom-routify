<script>
  import { redirect } from "@roxi/routify";
  import { UserStore } from "../stores/user";
  import { onDestroy } from "svelte/internal";
  import axios from "axios";

  let userInput = { emailInput: "max@test.de", passWordInput: "max12345" };

  let myCurrentUser = null;

  // Die aktuellen Werte aus dem UserStore werden in die lokale Variable
  // myCurrentUser übertragen und UserStore wird abonniert
  const unsubscribe = UserStore.subscribe((currentUser) => {
    myCurrentUser = { ...currentUser };
  });

  function handleSubmit() {
    axios
      .post("http://localhost:4000/user", {
        type: "login",
        email: userInput.emailInput,
        password: userInput.passWordInput,
      })
      // then holt mir die data aus axios und dieser antwort "Payload" habe ich an das nächste then() weitergegeben
      // Der Server hat einen Response zurückgegeben nach findOne()
      .then((res) => res.data)
      .then((data) => {
        // Userdaten vom Server in den Store uebertragen:
        myCurrentUser = { ...data.user };
        UserStore.set(myCurrentUser);
        // localStorage.setItem("svelteJWT", myCurrentUser.user)
        // Catalog automatisch aufrufen
        $redirect("/catalog");
        console.log(data);
        // storeCurrentUserToReduxStoreToLogin(data.user);
      })
      .catch((error) => {
        // message vom Server, wenn die daten im Server nicht gefunden werden
        alert(error.response.data.message);
      });
  }

  onDestroy(unsubscribe);
</script>

<div class="login-base-container card">
  <!-- on:submit|preventDefault={handleSubmit} -->
  <div class="form">
    <h1 class="title-cont is-medium">BOOM | Log In</h1>
    <div class="form-container">
      <label for="email" class="li-label">Your E-Mail</label>
      <input
        required
        type="email"
        class="input is-rounded"
        placeholder="Your E-Mail"
        bind:value={userInput.emailInput}
      />
      <label for="password" class="li-label">Your Password</label>
      <input
        class="input is-rounded"
        type="password"
        placeholder="Your Password"
        bind:value={userInput.passWordInput}
      />
      <a href="/" class="form-container__pass"
        >Password forgotten? Choose New!</a
      >
    </div>

    <button
      on:click|preventDefault={handleSubmit}
      class="button is-rounded is-primary li-btn"
      >Log In
    </button>
    <div class="para-contianer">
      <p class="para-contianer__title">Password forgotten?</p>
      <span class="line">|</span>
      <a class="para-contianer__title2" href="/signup">New Member?</a>
    </div>
  </div>
</div>

<style global lang="scss">
  @import "../main.scss";
  .login-base-container {
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
    .login-base-container {
      width: 300px;
      padding: 5px 5px;
      margin: 10px;
    }
  }
  .form {
    padding: 2rem 1.5rem 0 1.5rem;
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
  .li-label {
    padding-bottom: 2px !important;
    margin-top: 2rem;
    padding: 10px calc(calc(0.75em - 2px) + 0.375em);
  }
  .button,
  .para-contianer {
    padding: 1rem 1.5rem;
  }
  .li-btn {
    margin-top: 2rem;
    justify-content: center;
    font-size: 1.1rem;
    font-family: "Sofia";
    background: #db4e61 !important;
    // color: rgb(31, 28, 28);
    width: 100%;
  }
  .para-contianer {
    display: flex;
    gap: 5px;
    justify-content: flex-end;
  }
  .para-contianer__title {
    color: rgb(77, 75, 75);
    text-align: right;
    font-family: "Patrick Hand";
  }
  .para-contianer__title:hover,
  .form-container__pass:hover,
  .para-contianer__title2 {
    cursor: pointer;
    color: #db4e61;
  }
  .para-contianer__title2 {
    color: $pinky;
  }
  .line {
    color: rgb(31, 28, 28);
  }
  .form-container__pass {
    padding: 1.5rem 1rem;
    color: rgb(77, 75, 75);
    font-size: 10px;
    text-decoration: underline;
  }
</style>
