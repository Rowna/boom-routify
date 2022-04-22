<script>
  import { app } from "./stores/app"
  import firebase_config from "./server/firebase_config";

  // Firebase 9
  import { initializeApp } from "firebase/app";  

  import { Router } from "@roxi/routify";
  import { routes } from "../.routify/routes";

  app.subscribe(() => {})

  // Firebase 9
  const fb = initializeApp(firebase_config);

  
</script>

<Router {routes} /> 

<!--  -->
<style global lang="scss">
  @import "./main.scss";
  .block {
    padding: 2rem 6rem;
  }

</style>
