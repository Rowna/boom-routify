<script>
  import { redirect } from "@roxi/routify";

  import {
    doc,
    getDoc,
    getFirestore,
  } from "firebase/firestore";

  import {
    getAuth,
    onAuthStateChanged,
  } from "firebase/auth";

  const db = getFirestore();

  const fbAuth = getAuth();
  let user = fbAuth.currentUser; 
  let fullUserName = "";
  let logoutButton = false;

  // wenn sich zb auf der login-page oder der signup-page der Auth-Status aendert ...
  onAuthStateChanged(fbAuth, (fbUser) => {
    user = fbUser;

    // Falls der user neu eingeloggt ist ...
    if (fbUser !== null) {
      // wahren Benutzernamen aus '/firestore/users/$app.user.id' holen
      getDoc(doc(db, `users/${user.uid}`))
        .then((snapshot) => {
          fullUserName = snapshot.data().name;
          console.log(fullUserName);
        })
        .catch((error) => "Konnte den Username nicht laden:" + error.message);
    } else {
      user = null; // wird schon in Z.30 geklaert.
      console.log("User is signed out! ");
    }
  });

  function logoutHandler() {
    logoutButton = true;
    fbAuth
    // ist ASYNCHRON, d.h. die noetigen anpassungen im
    // .then vornehmen.
    .signOut()
    .then(() => {
      // location.reload();
      window.location.href = window.location.href;
      user = fbAuth.currentUser;
        console.log("Ausgeloggt!");
        $redirect("/");
      })
      .catch((error) => "Konnte nicht ausloggen: " + error.message);
  }
</script>

<!-- svelte-ignore a11y-no-redundant-roles -->
<nav class="navbar" role="navigation" aria-label="main navigation">
  <div class="navbar-brand">
    <a class="navbar-item logo" href="/">BOOM</a>
    <!-- Mobile Version / If User nicht eingeloggt -->
    {#if !fbAuth.currentUser && !logoutButton}
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
        <div class="navbar-end">
          <a class="navbar-btn button is-white" href="/cart">Cart</a>
          <div class="select is-white">
            <select class="sel">
              <option>{fullUserName}</option>
              <option on:click={logoutHandler}>Logout</option>
            </select>
          </div>
        </div>
      </div>
    {/if}
  </div>

  <div id="navbarBasicExample" class="navbar-menu">
    <div class="navbar-end">
      <div class="navbar-item">
        <div class="buttons">
          <!-- Desktop Version / If User nicht eingeloggt ist -->
          {#if !fbAuth.currentUser && !logoutButton}
            <a class="button singup is-primary" href="/signup">
              <strong>Sign up</strong>
            </a>
            <a href="/login" class="button is-light">Log In</a>
          {:else}
            <div class="header-menu">
              <div>
                <a class="button is-white" href="/cart">Shopping Cart</a>
              </div>
              <div class="imge">
                <img src="../images/herz.png" alt="Fav" />
              </div>
              <div class="select is-white">
                <select class="sel">
                  <option>{fullUserName}</option>
                  <option on:click={logoutHandler}>Logout</option>
                </select>
              </div>
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
  .navbar-brand {
    padding: 0;
  }

  @media only screen and (max-width: 1024px) {
    .nav-itm {
      justify-content: flex-end;
      margin-left: auto;
    }
  }
  @media only screen and (min-width: 1023px) {
    .nav-itm {
      display: none;
    }
  }
</style>
