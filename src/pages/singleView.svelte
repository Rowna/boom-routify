<script>
  import { getAuth } from "firebase/auth";
  import { doc, getFirestore } from "firebase/firestore";

  const db = getFirestore();
  const fbAuth = getAuth();
  let user = fbAuth.currentUser;

  /*  
  Spec: 
  User-Id ist user.uid: Das wird gebraucht, wenn eine neue Rec-Abfrage abgeschickt wird
  articleID: brauchen wir, damit die neue Rec. beim richtigen Artiekl eingetragen wird.#
    sie steht als Endpoint in der URL, die uns auf diese Seite gefuehrt hat:
       http://localhost:5000/singleView/54812nfqi8291
    die 54812nfqi8291 ist die artikel-ID, die wir auch in der 'articles'-collection finden.
    Wie man an diese ID herankommt, steht in der Routify-Dokumentation. Muss recherchiert
    werden.

  für die Einzelansicht: braucht man das richtige getDoc(articleRef).then().catch();
                // 
  articleRef = doc(db, "articles", articleID);
  getDoc(articleRef)
    .then((docsnap) => {
      if(docsnap.exists())
        // es wurde was passendes gefunden ;
        // wir haben jetzt alle article-Daten

      else
        throw new Error("Nix passendes gefunden!");
    })
    .catch((error) => {
      console.log("So eine Scheisse! " + error.message);
    });

  Wenn wir den Artikel haben, haben wir auch alle existierenden Recs!
  
 */

  // articleRef = doc();
</script>

<div class="cart-title">
  <p>BOOM</p>
  <p class="subtitle is-7">Rate your article and read more about it!</p>
</div>
<!-- <p class="title">Hello from the Einzelansicht :)</p> -->

<!-- <div class="box"> -->
<div class="base-container">
  <div class="card">
    <div class="card-footer article-conatiner">
      <!-- Das Image mit den Bewertungssternen -->
      <div class="card-footer-item img-container">
        <div>
          <img class="img" src="images/12.jpeg" alt="Bild" />
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
          <h2 class="article-title title is-4">Dress Winter Red</h2>
          <p class="article-price subtitle is-5">Preis: 20.00 €</p>
          <p class="article-desc subtitle is-6">
            Soft Dress for all ages of kids with more pretty colours Soft Dress
            for all ages of kids with more pretty colours Soft Dress for all
            ages of kids with more pretty colours Soft Dress for all ages of
            kids with more pretty
          </p>
        </div>

        <div class="rate-btn-container">
          <a class="button is-danger rate-btn" href="/">Rate this Article</a>
        </div>
      </div>
    </div>
  </div>

  <br />

  <div class="card">
    <div class="">
      <div class="card-footer-item">
        <p class="title is-4">Kunden Rates:</p>
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
      text-align: center;
      max-width: 1000px;
      width: 100%;
    }
  }

  @media only screen and (max-width: 1024px) {
    .base-container {
      margin: 5rem 2rem 0 2rem;
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
  .rate-btn {
    width: 100%;
  }
</style>
