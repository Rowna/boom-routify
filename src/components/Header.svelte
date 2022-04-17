<script>
  import { getFirestore, getDoc, doc } from "firebase/firestore";
  import { app } from "../stores/app";
  import { getAuth } from "firebase/auth";

  const db = getFirestore();
  let fullUserName = "";
  const fbAuth = getAuth();

  let fbUser = {};

  // Falls der user eingeloggt ist ...
  if ($app.user) {
    // wahren Benutzernamen aus '/firestore/users/$app.user.id' holen
    getDoc(doc(db, `users/${$app.user.uid}`))
      .then((snapshot) => {
        // in die bereitgestellte Variable uebertragen
        fullUserName = snapshot.data().name;
      })
      .catch((err) => "Konnte den Username nicht laden:" + err.message);
  }

  function LogoutHandler() {
    // console.log("Ich bin logout!");
    fbAuth.signOut().then(() => {
      console.log("SignOut fertig!");
    });
    // $app.set({ user: fbUser });
  }
</script>

<!-- svelte-ignore a11y-no-redundant-roles -->
<nav class="navbar" role="navigation" aria-label="main navigation">
  <div class="navbar-brand">
    <a class="navbar-item logo" href="/">BOOM</a>
    {#if !$app.user}
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
    {:else}
      <div class="navbar-item nav-itm">
        <a class="navbar-btn button is-white" href="/shoppingCart"
          >Shop Cart</a
        >

        <div class="select is-white">
          <select class="sel">
            <option>{fullUserName}</option>
            <option on:click={LogoutHandler}>Sign Out</option>
          </select>
        </div>

        <!-- <a class="navbar-btn button is-white" href="/">{fullUserName}</a> -->
      </div>
    {/if}
  </div>

  <div id="navbarBasicExample" class="navbar-menu">
    <div class="navbar-end">
      <div class="navbar-item">
        <div class="buttons">
          {#if !$app.user}
            <a class="button singup is-primary" href="/signup">
              <strong>Sign up</strong>
            </a>
            <a href="/login" class="button is-light">Log In</a>
          {:else}
            <!-- <p>Buttons fuer den eingeloggten user</p> -->
            <div class="header-menu">
              <div>
                <a class="button is-white" href="/shoppingCart">Shopping Cart</a
                >
              </div>
              <div class="imge">
                <img src="../images/herz.png" alt="Fav" />
              </div>
              {#if $app.user}
                <div class="select is-white">
                  <select class="sel">
                    <option>{fullUserName}</option>
                    <option on:click={LogoutHandler}>Sign Out</option>
                  </select>
                </div>
                <!-- {:else} -->
                <!-- <a href="/">Username</a> -->
              {/if}
            </div>
          {/if}
        </div>
      </div>
    </div>
  </div>
</nav>

<style>
  .singup {
    background-color: #df485b;
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
  /**/
  .navbar-brand {
    padding: 0;
  }

  @media only screen and (min-width: 470px) {
    .navbar-btn {
      padding: inherit;
    }
    .navbar-brand {
      justify-content: space-between;
    }
  }
  @media only screen and (min-width: 1023px) {
    .nav-itm {
      display: none;
    }
  }
</style>
