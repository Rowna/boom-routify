import { writable } from "svelte/store";

export const app = writable({
    // ist entweder null oder die Firebase user-Instanz
    // wird in /login bzw. /signup upgedated.
    // und bei einem Logout wieder zurueckgesetzt.
    user: null,
}); 