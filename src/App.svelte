<script>
  import { UserStore } from "./stores/user";
  import firebase_config from "./server/firebase_config";
  import { initializeApp } from "firebase/app";
  import { Router } from "@roxi/routify";
  import { routes } from "../.routify/routes";

  // UserStore.subscribe(() => {});

  

  const fb = initializeApp(firebase_config);
</script>

<Router {routes} />

<!-- Das bedeutet: Dynamisches Styling mit variablen aus main.scss -->
<style global lang="scss">
  @import "./main.scss";
  .block {
    padding: 2rem 6rem;
  }
</style>






