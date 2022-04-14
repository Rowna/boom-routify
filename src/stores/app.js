import { writable } from "svelte/store";

export const app = writable({
    // showLogin: false,
    // showSignup: false,
    user: null,
    // user: { name: "Perrin", "email": "perrin@gmail.com"},
}); 