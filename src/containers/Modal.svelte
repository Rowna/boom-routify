<script>
  import Stars from "./Stars.svelte";
  import { params } from "@roxi/routify";
  import {
    doc,
    getFirestore,
    updateDoc,
    getDoc,
    arrayUnion,
  } from "firebase/firestore";
  import { getAuth } from "firebase/auth";

  const db = getFirestore();
  const fbAuth = getAuth();

  let user = fbAuth.currentUser;
  let userFullName = "";

  let modalCSS = "modal is-active is-clipped";
  let recension = "";
  let myRating = 0;

  function getRating(rating) {
    myRating = rating;
    console.log("Aktuelles Rating: " + rating);
  }

  function closeModal() {
    modalCSS = "modal";
  }

  /* 
  Der Kommentar, der in der Input-Feld ist, muss in der FS Reco gespeichert sein.
  dafür brauchen wir aber  updateDoc();
  const recoRef = doc(db, "articles", $params.artID);
  updateDoc(recoRef).then((docsnapshot) => {}).catch();

  ABER: 
  if der User schon eine reco im FS schon vorhanden ist, 
  brauche ich keine ArrayUnion, weil die reco schon in FS da ist.
  Außerdem brauch ich auf Modal die Stene, um die mit dem Objekt
  "recommendation" mitgeschickt zu werden (zeile 40)


  */

  if (user !== null) {
    getDoc(doc(db, `users/${user.uid}`))
      .then((docsnapshot) => {
        userFullName = docsnapshot.data().name;
      })
      .catch((error) => "Konnte den Username nicht laden:" + error.message);
  } else {
    user = null;
    console.log("User is signed out! ");
  }

  /* 
  sendHandler(): Schickt eine neue Rezension in den Firestore, 
  deshalb ist es ASYNCHRON.

  */
  async function sendHandler() {
    /* 
    const recoRef = doc(db, "articles", $params.artID);

    // Neue Recommendation im FS bauen und schicken.
    // Regel: Firebase akzeptiert nur ein vollstaendiges Dokument!
    let recommendation = {
      rating: myRating,        // int: 
      text: recension,
      userId: user.uid,
      createdAt: Date.now(), // :BigInt: Millisekunden seit 1.1.1970 00:00 Uhr GMT 
      username: userFullName, // userFullName muss noch aus FS geholt werden dazu ab zeile: 41
    };
    updateDoc(recoRef, {
      recommendations: arrayUnion(recommendation),
    });
  */
  }

  /* 
  getDoc(recoRef)
    .then((docsnapshot) => {
        console.log(docsnapshot);

        if (docsnapshot.exists()) {
        recommendation = { ...docsnapshot.data() };
      } else {
        throw new Error("Nix passendes gefunden!");
      }
    })
    .catch((error) => {
      console.log("So eine Scheisse! " + error.message);
    });
*/
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
          bind:value={recension}
          class="input is-primary"
          placeholder="Your Recension"
          required
          type="text"
        />
      </div>
      <Stars {getRating} />
    </section>
    <footer class="modal-card-foot">
      <button class="button is-success" on:click={sendHandler}>Send it</button>
    </footer>
  </div>
</div>

<style>
  @media only screen and (min-width: 350px) {
    .modal-card {
      margin: 0 2rem 0 2rem;
    }
  }
  @media only screen and (max-width: 770px) {
    .modal-card {
      margin: 0;
    }
  }
</style>
