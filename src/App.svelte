<script>
  import { UserStore } from "./stores/user";
  import { onDestroy } from "svelte/internal";
  // import firebase_config from "./server/firebase_config";
  // import { initializeApp } from "firebase/app";
  import { Router } from "@roxi/routify";
  import { routes } from "../.routify/routes";

  let myCurrentUser = null;

  const unsubscribe = UserStore.subscribe((currentUser) => {
    myCurrentUser = currentUser;
  });

  const localCurrentUser = localStorage.getItem("svelteCurrentUser")
  // steht localCurrentUser im localStorage?
  if ( localCurrentUser !== null ) {
    // current User aus localStorage auslesen
    myCurrentUser = JSON.parse(localCurrentUser);
    // User store mit dem current user fuellen.
    UserStore.set(myCurrentUser)
  }
  

  // const fb = initializeApp(firebase_config);
  onDestroy(unsubscribe)

</script>

<Router {routes} />

<!-- Das bedeutet: Dynamisches Styling mit variablen aus main.scss -->
<style global lang="scss">
  @import "./main.scss";
  .block {
    padding: 2rem 6rem;
  }
</style>






