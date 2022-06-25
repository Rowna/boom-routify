<script>
  // ein func Prop;
  // Wird benoetigt, um ein Rating an das Parent-Component
  // zu schicken.
  export let getRating = null;

  /*
  import { getAuth } from "firebase/auth";
  import {
     getDoc,
     doc, 
     getFirestore 
    } from "firebase/firestore";

  const fbAuth = getAuth();
  const user = fbAuth.currentUser;

  const articleRef = doc(db, "articles", $params.artID);
  let recommendations = null;


  getDoc(articleRef)
    .then((docsnapshot) => {
      if (docsnapshot.exists()) {
        article = { ...docsnapshot.data() };
        recommendations = article.recommendations;        
      } else {
        throw new Error("Nix passendes gefunden!");
      }
    })
    .catch((error) => {
      console.log("So eine Scheisse! " + error.message);
    });


   function isRated() {
    for (let el of recommendations) {
      if (el.userId === user.id) return true;  
    }
    return false;
  }

  */
</script>

<p class="sternebewertung">
  <input type="radio" id="stern5" name="bewertung" value="5" />
  <label
    for="stern5"
    title="5 Sterne"
    on:click={() => getRating(5)}>5 Sterne</label
  >
  <input type="radio" id="stern4" name="bewertung" value="4" />
  <label
    for="stern4"
    title="4 Sterne"
    on:click={() => getRating(4)}>4 Sterne</label
  >
  <input type="radio" id="stern3" name="bewertung" value="3" />
  <label
    for="stern3"
    title="3 Sterne"
    on:click={() => getRating(3)}>3 Sterne</label
  >
  <input type="radio" id="stern2" name="bewertung" value="2" />
  <label
    for="stern2"
    title="2 Sterne"
    on:click={() => getRating(2)}>2 Sterne</label
  >
  <input type="radio" id="stern1" name="bewertung" value="1" />
  <label
    for="stern1"
    title="1 Stern"
    on:click={() => getRating(1)}>1 Stern</label
  >

  <span id="Bewertung" title="Keine Bewertung">
    <label on:click={() => getRating(0)}>
      <input type="radio" name="bewertung" value="0" checked="checked" /> Cancel
      Rates
    </label>
  </span>
</p>

<style>
  /* Sternebewertung */
  span#Bewertung label {
    line-height: 45px;
    cursor: Pointer;
  }
  p.sternebewertung {
    float: Left;
  }

  p.sternebewertung:not(:checked) > input {
    display: None;
  }

  p.sternebewertung:not(:checked) > label {
    float: Right;
    width: 1em;
    padding: 0 0.1em;
    overflow: Hidden;
    white-space: Nowrap;
    cursor: Pointer;
    font-size: 200%;
    line-height: 1.2;
    color: #d0d0d0;
    text-shadow: 1px 1px #b0b0b0, 2px 2px #606060,
      0.1em 0.1em 0.2em rgba(0, 0, 0, 0.5);
    transition: all 0.5s;
  }

  p.sternebewertung:not(:checked) > label::before {
    content: "★ ";
  }

  p.sternebewertung > input:checked ~ label {
    color: #ffd700;
    text-shadow: 1px 1px #c06000, 2px 2px #904000,
      0.1em 0.1em 0.2em rgba(0, 0, 0, 0.5);
    animation: twinkle 1s ease-in-out infinite alternate;
  }

  p.sternebewertung:not(:checked) > label:hover,
  p.sternebewertung:not(:checked) > label:hover ~ label {
    color: #fecf41;
    text-shadow: 1px 1px #f29e02, 2px 2px #b57340,
      0.1em 0.1em 0.2em rgba(0, 0, 0, 0.5);
  }

  p.sternebewertung > input:checked + label:hover,
  p.sternebewertung > input:checked + label:hover ~ label,
  p.sternebewertung > input:checked ~ label:hover,
  p.sternebewertung > input:checked ~ label:hover ~ label,
  p.sternebewertung > label:hover ~ input:checked ~ label {
    color: #fbb600;
    text-shadow: 1px 1px #f8ba01, 2px 2px #b57340,
      0.1em 0.1em 0.2em rgba(0, 0, 0, 0.5);
  }

  @keyframes twinkle {
    to {
      text-shadow: 1px 1px #ffe653, 2px 2px #fff5bf,
        0.1em 0.1em 0.2em rgba(0, 0, 0, 0.5);
    }
  }
</style>
