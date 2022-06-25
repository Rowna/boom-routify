<script>
  import SetStars from "./SetStars.svelte";
  // import { params } from "@roxi/routify";
  // import {
  //   doc,
  //   getFirestore,
  //   updateDoc,
  //   getDoc,
  //   arrayUnion,
  // } from "firebase/firestore";
  // import { getAuth } from "firebase/auth";
  import axios from "axios";
  import { onMount, onDestroy } from "svelte/internal";
  import { UserStore } from "../stores/user";
  import { redirect } from "@roxi/routify";


  // let userFullName = "";
  export let article = {};
  export let updateArticle = null;

  let myCurrentUser = null;
  // Die aktuellen Werte aus dem UserStore werden in die lokale Variable
  // myCurrentUser übertragen und UserStore wird abonniert
  const unsubscribe = UserStore.subscribe((currentUser) => {
    myCurrentUser = { ...currentUser };
  });

  let modalCSS = "modal is-active is-clipped";
  let myRecommendations = [];
  let myRating = 0;
  let review = "";

  function getRating(rating) {
    myRating = rating;
    console.log("Aktuelles Rating: " + rating);
  }

  function closeModal() {
    modalCSS = "modal";
  }

  // if (user !== null) {
  //   getDoc(doc(db, `users/${user.uid}`))
  //     .then((docsnapshot) => {
  //       userFullName = docsnapshot.data().name;
  //     })
  //     .catch((error) => "Konnte den Username nicht laden:" + error.message);
  // } else {
  //   user = null;
  //   console.log("User is signed out! ");
  // }

  /* 
  sendHandler(): Schickt eine neue Rezension in den Firestore, 
  deshalb ist es ASYNCHRON.

  */
  // const recoRef = doc(db, "articles", $params.artID);
  async function sendHandler() {
    // Neue Recommendation im FS bauen und schicken.
    // Regel: Firebase akzeptiert nur ein vollstaendiges Dokument!
    let recommendation = {
      rating: myRating, // int:5 (Sterne 5)
      text: review,
      userId: myCurrentUser._id,
      createdAt: Date.now(), // :BigInt: Millisekunden seit 1.1.1970 00:00 Uhr GMT
      username: myCurrentUser.userName, // userFullName muss noch aus FS geholt werden dazu ab zeile: 41
    };

    axios
      .post("http://localhost:4000/sendRecommendation", {
        articleId: article._id,
        recommendation: recommendation,
      })
      .then((res) => res.data)
      // response comming from the server
      .then((data) => {
        console.log(data);
        updateArticle();
        closeModal();
        
      })
      .catch((err) => {
        console.log(err.message);
      });
  }

  // function updateArticle() {
  //   // die Recommendations aus dem aktuellen article holen:
  //   axios
  //     .get(`http://localhost:4000/getArticleById?_id=${article._id}`)
  //     .then((res) => res.data)
  //     .then((data) => {
  //       myRecommendations = data.recommendations;
  //     });
  // }

  // updateDoc(recoRef, {
  //   // wenn der reco-Objekt im FS leer ist, dann füge das recommendation-objekt hinzu.
  //   // ABER: wenn der user eine reco geschrieben hat, DARF er NICHT
  //   // nochmal einen Review schreiben.
  //   recommendations: arrayUnion(recommendation),
  // })
  //   .then((_) => {
  //     closeModal();
  //     window.location.href = window.location.href;
  //   });

  onDestroy(unsubscribe);
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
        You can write here your review about this article:
      </p>
      <div>
        <input
          class="input is-primary"
          placeholder="Your review"
          bind:value={review}
          required
          type="text"
        />
      </div>
      <SetStars {getRating} />
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
  .modal-background{
    position: fixed;
  }
</style>
