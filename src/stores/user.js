import { writable } from "svelte/store";

export const UserStore = writable({
    userId: "",
    email: "",
    userName: "",
    token: "",
}); 