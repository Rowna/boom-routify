<script>
  import { redirect } from "@roxi/routify";
  import axios from "axios";
  import { UserStore } from "../stores/user";
  import { onDestroy } from "svelte/internal";

  let userInput = { fullNameInput: "", emailInput: "", passWordInput: "" };
  let errors = { fullName: "", mail: "", passWord: "" };
  let isValid = false;

  let myCurrentUser = null;

  // Die aktuellen Werte aus dem UserStore werden in die lokale Variable
  // myCurrentUser übertragen und UserStore wird abonniert
  const unsubscribe = UserStore.subscribe((currentUser) => {
    myCurrentUser = { ...currentUser };
  });

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
  }

  function submitHandler() {
    // Felder Validieren!
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
      console.log("isValid = true!");
      isValid = true;
    }
    // axios schickt eine Request an den Server.js
    // body dieser Request: {type, email, password...}
    axios
      .post("http://localhost:4000/user", {
        type: "signup",
        email: userInput.emailInput,
        password: userInput.passWordInput,
        userName: userInput.fullNameInput,
      })
      // der Server gibt zurück einen Response
      .then((res) => res.data)
      .then((data) => {
        // Userdaten vom Server in den Store uebertragen:
        myCurrentUser = { ...data.user };
        console.log(data.user)
        console.log(myCurrentUser)
        UserStore.set(myCurrentUser);
        $redirect("/catalog");
        alert(data.message);
      });

    /*
    createUserWithEmailAndPassword(
      fbAuth,
      userInput.emailInput,
      userInput.passWordInput
    )
      .then((fbCredentials) => {
        // ab hier ist der User eingeloggt, weil user nicht laenger null ist.
        // das firebase SDK sorgt jetzt ohne meine Mitarbeit dafuer, dass der Token
        // bei jeder Datenbankabfrage an firebase zurueckgeschickt wird.
        // Damit hat Firebase automatisch alle Daten, die es braucht, um zu entscheiden,
        // ob der User Zugriff auf Datenbankdaten hat oder nicht.
        console.log("Registrierung scheinbar erfolgreich!");
        fbUser = fbCredentials.user;
        console.log("Aktuelle UserID: " + fbUser.uid);
        // app.set({ user: fbUser });

        // wenn ich das user-objekt von firebase erhalten habe, muss ich ausserdem noch
        // einen user in der "users"-Collection anlegen. Dieser Eintrag muss folgende
        // Bedingungen erfuellen:
        //    * Die IDs in der Auth-Datenbank und in der "users"-DB muessen 1:1 gleich sein.
        //    * Im Firestore wird der Name aus der Signup-Maske eingetragen.

        // einen neuen Benutzer mit der ID $app.user.uid in Firestore anlegen!
        // und den vollstaendigen Namen dort ablegen. (userInput.fullNameInput)
        // setDoc() ist wieder ASYNCHRON, d.h. es gibt ein Ergebnis zurueck, das
        // erneut in ein Promise "verpackt" wird. dieses Ergebnis wird der
        // Form halber im naechsten .then() als callback-argument eingefangen.
        return setDoc(doc(db, `/users/${fbUser.uid}`, ""), {
          name: userInput.fullNameInput,
        });
      })
      .then((setDocResult) => $redirect("/catalog"))
      .catch((err) => {
        console.log(
          "Uh oh! Konnte keinen neuen Nutzer anlegen: " + err.message
        );
      });
  */
  }
  onDestroy(unsubscribe);
</script>

<div class="signup-base-container">
  <div on:submit|preventDefault={submitHandler} class="form">
    <h1 class="signup-boom-title is-medium">BOOM | Sign Up</h1>
    <div class="form-container">
      <label for="name">Full Name</label>
      <input
        required
        type="text"
        bind:value={userInput.fullNameInput}
        class="input is-rounded"
        placeholder="Your Full Name"
      />
      <p class="error-message">{errors.fullName}</p>

      <label for="email">E-Mail</label>
      <input
        required
        type="email"
        bind:value={userInput.emailInput}
        class="input is-rounded"
        placeholder="Your E-Mail-Adress"
      />
      <p class="error-message">{errors.mail}</p>

      <label for="password">Password</label>
      <input
        required
        type="password"
        bind:value={userInput.passWordInput}
        class="input is-rounded"
        placeholder="A Strong Password"
      />
      <p class="error-message">{errors.passWord}</p>
    </div>
  </div>
  <div class="btn-contianer">
    <button
      on:click|preventDefault={submitHandler}
      class="button is-rounded is-primary sign-up">Sign Up</button
    >
    <div class="para-contianer">
      <a href="/login" class="para__title">Already have an Account?</a>
    </div>
  </div>
  <div />
</div>

<style>
  .signup-base-container {
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
    .signup-base-container {
      width: 300px;
      padding: 5px 5px;
      margin: 10px;
    }
  }

  .form {
    padding: 2rem 1.5rem;
  }
  .signup-boom-title {
    color: #000;
    font-family: "Sofia";
    font-size: 1.5rem;
    margin-bottom: 0;
    position: relative;
    margin-bottom: 2.7rem;
  }
  .signup-boom-title::after {
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
    font-family: inherit;
    padding: 10px calc(calc(0.75em - 2px) + 0.375em);
    /* margin-top: 15px; */
  }
  .error-message {
    padding: 5px calc(calc(0.75em - 2px) + 0.375em);
    color: red !important;
    font-size: 14px;
    margin-top: 5px;
  }
  .is-primary {
    font-family: "Sofia";
    color: rgb(31, 28, 28);
    width: 100%;
  }
  .sign-up {
    box-shadow: #9c9898;
    justify-content: center;
    background-color: rgb(116, 195, 116) !important;
  }
  .input {
    border: none !important;
  }
  .btn-contianer {
    padding: 0 1.5rem 10px 1.5rem;
  }
  .para-contianer {
    max-width: fit-content;
    text-align: end;
    float: right;
    width: 250px;
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
