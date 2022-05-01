<script>
  import { getAuth } from "firebase/auth";
  import { doc, getFirestore, getDoc } from "firebase/firestore";
  import { params } from "@roxi/routify";
  import Modal from "../../containers/Modal.svelte"
 
  const db = getFirestore();
  const fbAuth = getAuth();
  let user = fbAuth.currentUser;
  
  // Modal ist nicht zu sehen
  let modalVisible = false;

  function ratingHandler() {
    // Ab jetzt ist Modal zu sehen
    modalVisible = true;
    console.log("Rating Klicked ");
  }

  /*
    hier muessen wir irgendwie ereignisgesteuert
    modalVisible = false;
    einstellen, wenn der User auf den Canvas klickt
    oder auf den Cancel-button im Modal
    oder auf den "Send It" Button im Modal.
  
    DENKEN, Rona, DENKEN!
    Wir haben gestern genau so eine Technik implementiert!
    Und wir muessen sie sofort mit implementieren,
    sonst bekommen wir das Modal nicht wieder abgeschaltet,
    wenn es einmal auf dem Viewport ist.
  */

  /*  
  Spec: 
  User-Id ist user.uid: Das wird gebraucht, wenn eine neue Rec-Abfrage abgeschickt wird
  Das brauchen wir aber erst, wenn wir das Modal haben.

  articleID: brauchen wir, damit die neue Rec. beim richtigen Artiekl eingetragen wird.
    sie steht als Endpoint in der URL, die uns auf diese Seite gefuehrt hat:
       http://localhost:5000/singleView/54812nfqi8291
    die 54812nfqi8291 ist die artikel-ID, die wir auch in der 'articles'-collection finden.
    Wie man an diese ID herankommt, steht in der Routify-Dokumentation. Muss recherchiert
    werden.

  Wenn wir den Artikel haben, haben wir auch alle existierenden Recs!
  
 */
  let article = {};
  // das aktuelle article-doc aus FS holen
  // für die Einzelansicht: braucht man das richtige getDoc(articleRef).then().catch();

  const articleRef = doc(db, "articles", $params.artID);
  getDoc(articleRef)
    .then((docsnapshot) => {
      if (docsnapshot.exists()) {
        // es wurde was passendes gefunden ;
        // wir haben jetzt alle article-Daten
        // Eine Kopie klonen mit spread-operator
        article = { ...docsnapshot.data() };
        // console.log(article.recommendations);
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
<!-- <h1>Die Artikelnummer für diesen Artikle ist: {$params.artID}</h1> -->

<!-- <p class="title">Hello from the Einzelansicht :)</p> -->

<!-- <div class="box"> -->

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
        <div class="sterne">Hier kommen die Sterne!</div>
      </div>

      <!-- Die Beschreibung des Artikels -->
      <div class="card-footer-item desc-container">
        <div>
          <h2 class="article-title title is-4">{article.title}</h2>
          <p class="article-price subtitle is-5">{article.price} €</p>
          <p class="article-desc subtitle is-6">{article.desc}</p>
        </div>
        <!-- Das ist das Modal für Rating -->
        <p class="rate-btn-container" on:click={ratingHandler}>
          <!-- svelte-ignore a11y-missing-attribute -->
          <a class="button is-info rate-btn">Rate this Article</a>
        </p>

        <!-- Hier kommt das Modal -->

        <!--   -->
        {#if modalVisible}
        <Modal />
        {/if}

        <!-- Button für "Back to Gallery" -->
        <p class="rate-btn-container">
          <a class="button is-info gly-btn" href="/catalog">Back to Gallery</a>
        </p>
      </div>
    </div>
  </div>

  <br />

  <div class="card">
    <div class="">
      <div class="card-footer-item">
        <p class="title is-4">Customer Ratings:</p>
      </div>
      <div class="card-footer">
        <div class="card-footer-item kunden-container">
          <p class="person">Otto Wohlgemut<br />4 Sterne</p>
          <!-- Hier kommen die Sterne hin, die otto Wohlgemut für diesen Artikle vergeben hat -->
          <!-- <div class="sterne">Hier kommen die Sterne!</div> -->

          <div class="card-footer-item">
            Soft Dress for all ages of kids with more pretty colours Soft Dress
            for all ages of kids with more pretty colours Soft Dress for all
            ages of kids with more. khjhkj kkfhkjshfkh lkjfkfhiadhfaföl
            kndfkjhaöfhaäfaf
          </div>
        </div>
      </div>

      <div class="card-footer">
        <div class="card-footer-item kunden-container">
          <p class="person">Lilly Lichtling<br />5 Sterne</p>
          <div class="card-footer-item">
            Soft Dress for all ages of kids with more pretty colours Soft Dress
            for all ages of kids with more pretty colours Soft Dress for all
            ages of kids with more. khjhkj kkfhkjshfkh lkjfkfhiadhfaföl
            kndfkjhaöfhaäfaf
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- </div> -->
<style>
  /* min heißt ab 1024 px */
  @media only screen and (min-width: 1024px) {
    .base-container {
      gap: 2rem;
      display: flex;
      flex-direction: column;
      margin-top: 4rem;
      margin-left: auto;
      margin-right: auto;
      /* flex-direction: column; */
      /* align-content: center; */
      text-align: left;
      max-width: 1000px;
      width: 100%;
    }
  }

  @media only screen and (max-width: 1024px) {
    .base-container {
      margin: 5rem 2rem 0 2rem;
      /* text-align: left; */

      /* display: flex; */
      /* flex-direction: column; */
      /* justify-content: center; */
      /* gap: 3rem; */
    }
  }

  @media only screen and (max-width: 690px) {
    .article-conatiner,
    .kunden-container {
      flex-direction: column;
    }
    .desc-container {
      margin: 0 15% 0 15%;
    }
    .img {
      width: 300px;
      height: 300px;
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
    gap: 2rem;
  }

  .img {
    object-position: center;
    width: 200px;
    height: 200px;
  }
  .rate-btn-container,
  .rate-btn,
  .gly-btn {
    width: 100%;
  }
  .rate-btn {
    background-color: #6acc6a;
  }
  .gly-btn {
    background-color: #df485b;
  }
</style>
