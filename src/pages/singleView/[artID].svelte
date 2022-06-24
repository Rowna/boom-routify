<script>
  // import { getAuth } from "firebase/auth";
  // import { doc, getFirestore, getDoc } from "firebase/firestore";
  import { params } from "@roxi/routify";
  import Modal from "../../containers/Modal.svelte";
  import Platzhalter from "../../containers/Platzhalter.svelte";

  import Stars from "../../containers/Stars.svelte";
  import RatingContainer from "../../components/RatingContainer.svelte";

  import { onMount, onDestroy } from "svelte/internal";
  import { UserStore } from "../../stores/user";
  import axios from "axios";

  // const db = getFirestore();
  // const fbAuth = getAuth();
  // let user = fbAuth.currentUser;

  let myCurrentUser = null;
  // Die aktuellen Werte aus dem UserStore werden in die lokale Variable
  // myCurrentUser übertragen und UserStore wird abonniert
  const unsubscribe = UserStore.subscribe((currentUser) => {
    myCurrentUser = { ...currentUser };
  });

  let article = {};
  let recommendations = null;
  let recAlreadyWritten = false;

  // Modal ist nicht zu sehen
  let modalVisible = false;
  let platzhalterVisible = false;

  function fnRecAlreadyWritten() {
    if (recommendations && recommendations.length > 0) {
      for (let el of recommendations) {
        if (el.userId === myCurrentUser.userId) return true;
        //  return recommendations.indexOf((el) => el.userId === user.uid) === -1;
      }
      return false;
    }
  }

  const closeModal = () => {
    modalVisible = false;
  };

  // $params.artID
  const getArticleById = (id) => {
    axios
      // get article where articleId = artID
      .get("http://localhost:4000/getArticleById?articleId=" + id)
      .then((res) => res.data)
      // response comming from the server
      .then((data) => {
        article = data.article;
        recAlreadyWritten = fnRecAlreadyWritten(data.article.recommendations);
      })
      .catch((err) => {
        console.log("The Error is: " + err.response.data.message);
      });
  };

  
  function ratingHandler() {
    // Ab jetzt ist Modal zu sehen
    if (myCurrentUser) {
      modalVisible = true;
    } else {
      alert("You should login!")
    }
    console.log("Rating Klicked");
  }

  function EditRatingHandler() {
    console.log("Edit geklickt! ... ");
    platzhalterVisible = true;
  }

  // onMount() ist useEffect(()=>{...}, []) in React
  onMount(() => getArticleById($params.artID))

  onDestroy(unsubscribe);

</script>

<div class="cart-title">
  <p>BOOM</p>
  <p class="subtitle is-7">Rate your article and read more about it!</p>
</div>

<div class="base-container">
  <div class="card">
    <div class="card-footer article-conatiner">
      <!-- Das Image mit den Bewertungssternen -->
      <div class="card-footer-item img-container">
        <div>
          <img class="img" src="/public/images/{article.img}" alt="Bild" />
          <!--         src="images/{article.img}" -->
        </div>
        <!-- 
          Hier kommt die Durchschnitts-Bewertung aller 
          Recommendations hin, die für diesem Artiekl schon
          abgegeben wurden.
          Gibt es noch keine Recommendations für diesen Artikel, 
          beleiben alle Sterne leer.
        -->
        <div class="card-footer-item sterne">
          <Stars />
        </div>
      </div>

      <!-- Hier kommt das Modal -->
      {#if modalVisible}
        <Modal 
            {article} {modalVisible} {closeModal} 
        />
      {/if}
      <br class="line" />

      <!-- Die Beschreibung des Artikels -->
      <div class="card-footer-item desc-container">
        <div>
          <h2 class="article-title title is-4">{article.title}</h2>
          <p class="article-price subtitle is-5">{article.price} €</p>
          <p class="article-desc subtitle is-6">{article.desc}</p>
        </div>

        <div class="btns card">
          <!-- Das ist das Modal für Rating -->
          <!--
            Entweder "Write your Recension" 
            oder "Edit your Recension"
          -->
          {#if recAlreadyWritten}
            <p class="rate-btn-container card-content">
              <!-- svelte-ignore a11y-missing-attribute -->
              <a class="button is-info edit-btn" on:click={EditRatingHandler}
                >Edit your Recension</a
              >
            </p>
            {#if platzhalterVisible}
              <Platzhalter />
            {/if}
          {:else}
            <p class="rate-btn-container card-content">
              <!-- svelte-ignore a11y-missing-attribute -->
              <a class="button is-info rate-btn" on:click={ratingHandler}
                >Write your Recension</a
              >
            </p>
          {/if}
          <!-- Button für "Back to Gallery" -->
          <p class="rate-btn-container card-content">
            <a class="button is-info gly-btn" href="/catalog">Back to Gallery</a
            >
          </p>
        </div>
      </div>
    </div>
  </div>

  <br />

  <!-- 
    Ich kann aus dem Rating-Block ein eigenes Komponent machen.
    Ich mache das mit Bulma-Klassen; ist sehr einfach

    <RatingContainer {recommendations} />
      {#each recommendations as rec }
        <Rating {rec} />
      {/each}
      ...
  -->
  {#if recommendations && recommendations.length > 0}
    <RatingContainer {recommendations} />
  {/if}
</div>

<style>
  .btns {
    width: 100%;
    margin-top: 1rem;
  }

  /* min heißt ab 1024 px */
  @media only screen and (min-width: 1024px) {
    .base-container {
      gap: 2rem;
      display: flex;
      flex-direction: column;
      margin-top: 4rem;
      margin-left: auto;
      margin-right: auto;
      text-align: left;
      max-width: 1000px;
      width: 100%;
    }
  }

  @media only screen and (max-width: 1024px) {
    .base-container {
      margin: 5rem 2rem 0 2rem;
    }
  }

  @media only screen and (max-width: 690px) {
    .article-conatiner {
      flex-direction: column;
    }
    .img {
      width: 300px;
      height: 300px;
    }
    .img-container {
      border-bottom: solid 2px #f5f5efc4;
    }
  }
  .cart-title {
    position: relative;
    font-family: "Sofia";
    font-size: 2.3rem;
    color: #000;
    display: grid;
    justify-items: center;
    text-align: center;

    grid-template-rows: 1fr 2rem;
    margin: 2rem 0 2rem 0;
  }
  .img-container,
  .desc-container {
    display: flex;
    flex-direction: column;
  }

  .img {
    object-position: center;
    width: 200px;
    height: 200px;
  }
  .rate-btn-container,
  .rate-btn,
  .gly-btn,
  .edit-btn {
    width: 100%;
  }
  .rate-btn {
    background-color: #6acc6a;
  }
  .gly-btn {
    background-color: #df485b;
  }
  .edit-btn {
    background-color: rgb(109, 169, 237);
    color: #000;
  }
</style>
