<script>
  import { app } from "./stores/app";
  import firebase_config from "./server/firebase_config";
  import { initializeApp } from "firebase/app";
  import { Router } from "@roxi/routify";
  import { routes } from "../.routify/routes";

  app.subscribe(() => {});

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






