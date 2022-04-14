import { writable } from "svelte/store";

export const app = writable({
    showLogin: false,
    showSignup: false,
}); 