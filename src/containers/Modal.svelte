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
  let myRecommendation = null;
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
  dafür brauche ich aber  updateDoc();
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
  const recoRef = doc(db, "articles", $params.artID);
  async function sendHandler() {
    // Neue Recommendation im FS bauen und schicken.
    // Regel: Firebase akzeptiert nur ein vollstaendiges Dokument!
    let recommendation = {
      rating: myRating, // int:5 (Sterne 5)
      text: recension,
      userId: user.uid,
      createdAt: Date.now(), // :BigInt: Millisekunden seit 1.1.1970 00:00 Uhr GMT
      username: userFullName, // userFullName muss noch aus FS geholt werden dazu ab zeile: 41
    };

    /*
      Schon beim Aufruf der Einzelansicht sollte geklaert werden, 
      ob der User schon einen kommentar geschrieben hat oder nicht.

      WENN er einen geschrieben hat,
        wird der Button "Write Recommendation" deaktiviert,
        und "seine" Recommendation in der Liste bekommt einen "Edit"-Button.
        
      Ich muss "Modal.svelte" refaktorisieren zu einem reinen Wrapper-Component
      (mit <slot>)
      
      WriteRecommendation.svelte
          import Modal from "/src/components/Modal.svelte"
          <Modal>
            <!-- Markup fuer das Erstellen einer neuen Recommendation -->
          </Modal>
      EditRecommendation.svelte
        Hier werden die aktuellen Werte aus der Recommendation
        In das Modal-Formular hineingeschrieben.
          import Modal from "/src/components/Modal.svelte"
          <Modal>
            <!-- Markup fuer das Editiren einer neuen Recommendation -->
          </Modal>

      Modal.svelte  // ein reines Wrapper-Component / Container-Component
          <div class="modal-container is-active">
            // hier kommt das Markup von entweder "WriteRecommendation.svelte"
            // oder "EditRecommendation.svelte" hinein.
            <slot />
          </div>
            
    */
    updateDoc(recoRef, {
      // wenn der reco-Objekt im FS leer ist, dann füge das recommendation-objekt hinzu.
      // ABER: wenn der user eine reco geschrieben hat, DARF er NICHT 
      // nochmal eine recension schreiben.
      recommendations: arrayUnion(recommendation),
    })
      .then((_) => {
        closeModal();
        window.location.href = window.location.href;
      });
  }

  /* */
  getDoc(recoRef)
    .then((docsnapshot) => {
      // console.log(docsnapshot);

      if (docsnapshot.exists()) {
        myRecommendation = { ...docsnapshot.data() };
      } else {
        throw new Error("Nix passendes gefunden!");
      }
    })
    .catch((error) => {
      console.log("So eine Scheisse! " + error.message);
    });


</script>

<!-- is-active muss eine "Dynamic Class" sein -->
<div class={modalCSS}>
  <div class="modal-background" on:click={closeModal} />
  <!-- /> -->

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
      margin: var(--top);
    }
  }
  @media only screen and (max-width: 770px) {
    .modal-card {
      margin: 0;
    }
  }
</style>
