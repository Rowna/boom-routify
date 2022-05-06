<script>
  import { getAuth } from "firebase/auth";
  import { doc, getFirestore, getDoc } from "firebase/firestore";
  import { params } from "@roxi/routify";
  import Modal from "../../containers/Modal.svelte";
  import Platzhalter from "../../containers/Platzhalter.svelte";

  import Stars from "../../containers/Stars.svelte";
  import RatingContainer from "../../components/RatingContainer.svelte";



    /* 
    1. Schon beim Aufbau der Einselansicht-Seite muss das article
    geladen werden.
    2. Dann muss bei diesem artikle geprueft werden, ob das artikle 
    einen Kommentar hat.
    3. Wenn er drinsteht, muessen die Sterne auf "Nummer von gegebenen 
    Sterne" gesetzt werden. 
    
    */
   
   function fnRecAlreadyWritten() {
     // console.log(recommendations[0].userId);
     // console.log("User Id '" + user.uid + "'");

     if (recommendations && recommendations.length > 0 )  {
       for (let el of recommendations) {
        if (el.userId ===  user.uid) 
        return true;
      //  return recommendations.indexOf((el) => el.userId === user.uid) === -1;
      }
      return false;
    }
  }
    
    /*
    for (let el of userCart) {
      if (el.id === article.id) return true;  
    }
    return false;
    }
    */

    
    function ratingHandler() {
      // Ab jetzt ist Modal zu sehen
    modalVisible = true;
    console.log("Rating Klicked");
  }

  function EditRatingHandler() {
    console.log("Edit geklickt! ... ");
    platzhalterVisible = true;
  }
  
  let article = {};
  const db = getFirestore();
  const fbAuth = getAuth();
  let recommendations = null;
  let recAlreadyWritten = false;
  let user = fbAuth.currentUser;

  // Modal ist nicht zu sehen
  let modalVisible = false;
  let platzhalterVisible = false;

  /*
    hier muss ich irgendwie ereignisgesteuert
    modalVisible = false;
    einstellen, wenn der User auf den Canvas klickt
    oder auf den Cancel-button im Modal
    oder auf den "Send It" Button im Modal.
  
    Ich habe gestern genau so eine Technik implementiert!
    Und ich muss sie sofort mit implementieren,
    sonst bekomme ich das Modal nicht wieder abgeschaltet,
    wenn es einmal auf dem Viewport ist.
  */

  /*  
  Spec: 
  User-Id ist user.uid: Das wird gebraucht, wenn eine neue Rec-Abfrage abgeschickt wird
  Das brauche ich aber erst, wenn ich das Modal habe.

  articleID: brauchen wir, damit die neue Rec. beim richtigen Artiekl eingetragen wird.
    sie steht als Endpoint in der URL, die uns auf diese Seite gefuehrt hat:
       http://localhost:5000/singleView/54812nfqi8291
    die 54812nfqi8291 ist die artikel-ID, die ich auch in der 'articles'-collection finde.
    Wie man an diese ID herankommt, steht in der Routify-Dokumentation. Muss recherchiert
    werden.

  Wenn ich den Artikel habe, habe ich auch alle existierenden Recs!
 */

  // das aktuelle article-doc aus FS holen
  // für die Einzelansicht: braucht man das richtige getDoc(articleRef).then().catch();

  const articleRef = doc(db, "articles", $params.artID);
  getDoc(articleRef)
    .then((docsnapshot) => {
      if (docsnapshot.exists()) {
        // es wurde was passendes gefunden ;
        // Ich habe jetzt alle article-Daten
        // Eine Kopie klonen mit spread-operator
        article = { ...docsnapshot.data() };
        // console.log(article.recommendations);
        // Zum Testen, ob der User eine Recension geschrieben hat oder nicht
        recommendations = article.recommendations;        

        recAlreadyWritten = fnRecAlreadyWritten();
      } else {
        throw new Error("Nix passendes gefunden!");
      }
    })
    .catch((error) => {
      console.log("So eine Scheisse! " + error.message);
    });
   
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
          <img class="img" src="/images/{article.img}" alt="Bild" />
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
        <Modal />
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
