<script>
    import Hero from "../components/Hero.svelte";
    // import { onDestroy } from "svelte";
    // import { app } from "./stores/app";

    /* 
    let showSignup;
    let showLogin;
    let unsubscribe;
    unsubscribe = app.subscribe((app) => {
      showSignup = app.showSignup;
      showLogin = app.showLogin;
    });
      // onDestroy(unsubscribe);
      onDestroy(() => {
        if (unsubscribe) {
          unsubscribe();
        }
      });
      */

  </script>
  
  <!-- <div class="landingpage__container"> -->
      <!--  
    {#if showSignup}
      <SignUpForm />
    {/if }
  
    {#if showLogin}
      <LoginForm />
    {/if }
   -->
   <div>
       <Hero />
   </div>