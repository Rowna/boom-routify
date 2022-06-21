<script>
  import { doc, getDoc, getFirestore } from "firebase/firestore";
  import { getAuth, onAuthStateChanged } from "firebase/auth";
  import { UserStore } from "../stores/user";
  import { onDestroy } from "svelte/internal";
  import { redirect } from "@roxi/routify";

  let myCurrentUser = null;

  const unsubscribe = UserStore.subscribe((currentUser) => {
    myCurrentUser = { ...currentUser };
  });

  const db = getFirestore();
  const fbAuth = getAuth();

  // let user = fbAuth.currentUser;
  let fullUserName = "";
  let logoutButton = false;

  function logoutHandler() {
    myCurrentUser = null;
    // UserStore updaten!
    UserStore.set(myCurrentUser);
    // localStorage.removeItem("svelteJWT");
    $redirect("/");
    window.location.href = window.location.href;
    console.log("Ausgeloggt!");
  }
</script>

<!-- svelte-ignore a11y-no-redundant-roles -->
<nav class="navbar" role="navigation" aria-label="main navigation">
  <div class="navbar-brand navbar-container">
    <a class="navbar-item logo" href="/">BOOM</a>
    <!-- Mobile Version / If User nicht eingeloggt -->
    {#if myCurrentUser.token.length > 0}
      <div class="navbar-item nav-itm">
        <div class="navbar-end">
          <a class="navbar-btn button is-white" href="/cart">Cart</a>
          <div class="select is-white">
            <select class="sel">
              <option>{myCurrentUser.userName}</option>
              <option on:click={logoutHandler}>Logout</option>
            </select>
          </div>
        </div>
      </div>
    {:else}
      <a
        href="/login"
        role="button"
        class="navbar-burger"
        aria-label="menu"
        aria-expanded="false"
        data-target="navbarBasicExample"
      >
        <span aria-hidden="true" />
        <span aria-hidden="true" />
        <span aria-hidden="true" />
      </a>
    {/if}
  </div>

  <div id="navbarBasicExample" class="navbar-menu">
    <div class="navbar-end">
      <div class="navbar-item">
        <div class="buttons">
          <!-- Desktop Version / If User nicht eingeloggt ist -->
          {#if myCurrentUser.token.length > 0}
            <div class="header-menu">
              <div>
                <a class="button is-white" href="/cart">Shopping Cart</a>
              </div>
              <a class="imge" href="/bookmark">
                <img src="../images/herz.png" alt="Fav" />
              </a>
              <div class="select is-white">
                <select class="sel">
                  <option>{myCurrentUser.userName}</option>
                  <option on:click={logoutHandler}>Logout</option>
                </select>
              </div>
            </div>
          {:else}
            <a class="button signup is-primary" href="/signup">
              <strong>Sign up</strong>
            </a>
            <a href="/login" class="button is-light">Log In</a>
          {/if}
        </div>
      </div>
    </div>
  </div>
</nav>

<style>
  .signup {
    background-color: #df485b;
    width: auto;
    font-family: inherit;
  }
  .logo {
    font-family: "Sofia";
    font-size: 1.5rem;
    color: rgba(0, 0, 0, 0.7);
  }
  .header-menu {
    display: flex;
  }
  .sel {
    color: hsl(0deg, 0%, 4%);
  }
  .imge {
    width: 28px;
    height: 28px;
  }
  .navbar-btn {
    padding: 3px;
  }
  .navbar-brand {
    padding: 0;
  }
  .navbar-container {
    margin-left: 2rem;
    justify-content: space-between !important;
  }

  @media only screen and (max-width: 1024px) {
    .nav-itm {
      justify-content: flex-end;
      margin-left: auto;
    }
  }
  /* min-width bedeutet: Ab 1023px wird es gelten */
  @media only screen and (min-width: 1023px) {
    .nav-itm {
      display: none;
    }
  }
</style>
