<script>
  // import Modal from "../containers/Modal.svelte";
  import { app } from "../stores/app";

  let userInput = { fullNameInput: "", emailInput: "", passWordInput: "" };
  let errors = { fullName: "", mail: "", passWord: "" };

  let isValid = false;

  // logInHandler wird aufgerufen, wenn der User auf Login-Button klickt
  function logInHandler() {
    const myNewGlob = {
      showLogin: true,
    };
    app.set(myNewGlob);
  }

  // Name Validierung durch RegEx
  function nameValid(pFullname) {
    var nameRegEx = /[A-Za-zäüö\\s\-]{3,}\s[A-Za-züöä\\-]{3,}/g;
    return nameRegEx.test(pFullname);
  }

  // Email Validierung durch RegEx
  function emailValid(pMail) {
    var mailRegEx = /^\w+@[a-zA-Z_]+\.[a-zA-Z]{2,}$/g;
    return mailRegEx.test(pMail);
  }

  // Password Validierung durch RegEx
  function passwordValid(pPassWord) {
    let isLongEnough = pPassWord.length >= 8;
    var passwordRegEx = /[A-Za-z-#\?!=@$%^&\*0-9]{8,}/g;
    return isLongEnough && passwordRegEx.test(pPassWord);
    // return isLongEnough;
  }

  // Form-Validierung
  function handelValidation() {
    let nameIsValid = false;
    let mailIsValid = false;
    let passwordIsValid = false;
    // Validate Fullname
    if (!nameValid(userInput.fullNameInput)) {
      errors.fullName = "Your full name please! Exp: Max Muster";
    } else {
      nameIsValid = true;
      errors.fullName = "";
    }
    // Validate E-Mail
    if (!emailValid(userInput.emailInput)) {
      errors.mail = "Your E-Mail! Exp: mu@m.de";
    } else {
      mailIsValid = true;
      errors.mail = "";
    }
    // Validate Password
    if (!passwordValid(userInput.passWordInput)) {
      errors.passWord = "A strong Password! Exp: Ma&123";
    } else {
      passwordIsValid = true;
      errors.passWord = "";
    }
    if (nameIsValid && mailIsValid && passwordIsValid) {
      isValid = true;
    }
  }

  function handleSubmit(data) {
    console.log("Submitting!");
    /* So hab ich mir die Daten vom BE vorgestellt
      if (
        userInput.fullNameInput == data.fullNameInput &&
        userInput.emailInput == data.emailInput
      ) {
        // Fehlermeldung in UI, dass die Daten im BE  existieren
      } else {
        sendData();
      }
      */
  }

  async function sendData() {
    let URL =
      "https://svelte-bulma-default-rtdb.europe-west1.firebasedatabase.app/users.json";
    console.log("Data Sent!");
    // 1. bring the URL
    // JSON.stringify() macht aus einem JavaScript-Objekt einen JSON-String
    // JSON.parse() macht aus einem JSON-String ein JavaScript-Objekt
    fetch(URL, {
      method: "POST",
      body: JSON.stringify(userInput),
      headers: {
        content: "application/json",
      },
    })
      // 2. then take it as a parameter "response" (when it is done)
      // Die response, die vom Backend-Server kommt, ist erst einmal
      // nur ein String. fetch() wandelt diesen String automatisch
      // in ein JS-Objekt um. Das Ergebnis wird als 'response' an
      // die anonyme Handler-Funktion in then() übergeben.
      .then((response) => {
        if (!response.ok) {
          throw new Error("Faild");
        }
        // ...
      })
      .catch((error) => {
        console.log(error);
      });
  }
</script>

<div class="base-container">
  <form on:submit={handleSubmit} class="form">
    <h1 class="title-cont is-medium">BOOM | Sing Up</h1>
    <div class="form-container">
      <!-- <div class="input-wrapp"> </div> -->
      <label for="name">Full Name</label>
      <input
        required
        type="text"
        bind:value={userInput.fullNameInput}
        class="input is-rounded"
        placeholder="Your Full Name"
      />
      <!-- {#if !isValid }    -->
      <p class="error">{errors.fullName}</p>
      <!-- {/if} -->
      <label for="email">E-Mail</label>
      <input
        required
        type="email"
        bind:value={userInput.emailInput}
        class="input is-rounded"
        placeholder="Your E-Mail-Adress"
      />
      <p class="error">{errors.mail}</p>

      <label for="password">Password</label>
      <input
        required
        type="password"
        bind:value={userInput.passWordInput}
        class="input is-rounded"
        placeholder="A Strong Password"
      />
      <p class="error">{errors.passWord}</p>
    </div>
  </form>
  <div class="btn-contianer">
    {#if !isValid}
      <button
        on:click={handelValidation}
        type="submit"
        class="button is-rounded is-primary check">Check Entries</button
      >
    {:else}
      <button
        on:click={handleSubmit}
        type="submit"
        class="button is-rounded is-primary sign-up">Sign Up</button
      >
    {/if}

    <!-- isTrue ? disabled : enabled  -->
  </div>
  <div class="para-contianer">
    <a href="/login" class="para__title">Already have an Account?</a>
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
    padding: 2rem 1.5rem;
  }
  .title-cont {
    color: #000;
    font-family: "Sofia";
    font-size: 1.5rem;
    margin-bottom: 0;
    position: relative;
    margin-bottom: 2.7rem;
  }
  .title-cont::after {
    position: absolute;
    content: "Hi there! Nice to see you!";
    color: #9c9898;
    width: 100%;
    font-family: "Patrick Hand";
    font-weight: normal;
    font-size: 0.9rem;
    left: 3.2rem;
    top: 36px;
  }
  .form-container {
    margin-top: 1.5rem;
    text-align: left;
    color: #000;
  }
  label {
    padding-bottom: 2px !important;
    /* margin-top: 15px; */
    padding: 10px calc(calc(0.75em - 2px) + 0.375em);
  }
  .error {
    padding: 5px calc(calc(0.75em - 2px) + 0.375em);
    color: red;
    font-size: 14px;
    margin-top: 5px;
  }
  .is-primary {
    font-family: "Sofia";
    /* background: #db4e61; */
    color: rgb(31, 28, 28);
    width: 100%;
  }
  .check {
    border: #db4e61 2px solid;
    background-color: #f8bbbb;
    box-shadow: 8px 10px 30px 20px rgba(200, 193, 193, 0.5);
  }
  .sign-up {
    box-shadow: #9c9898;
    background-color: rgb(116, 195, 116) !important;
  }
  .input {
    border: none !important;
  }
  .btn-contianer,
  .para-contianer {
    padding: 1rem 1.5rem;
  }
  .para-contianer {
    max-width: fit-content;
    text-align: end;
    float: right;
    width: 250px;
    /* margin-left: 17rem; */
  }
  .para__title {
    color: rgb(77, 75, 75);
    text-decoration: underline;
    text-align: right;
    font-family: "Patrick Hand";
  }
  .para__title:hover {
    cursor: pointer;
    color: #db4e61;
  }
</style>
