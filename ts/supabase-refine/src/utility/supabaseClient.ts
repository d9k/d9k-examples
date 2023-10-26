import { createClient } from "@refinedev/supabase";

// const SUPABASE_URL = "https://iwdfzvfqbtokqetmbmbp.supabase.co";
// const SUPABASE_KEY =
//   "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzMDU2NzAxMCwiZXhwIjoxOTQ2MTQzMDEwfQ._gr6kXGkQBi9BM9dx5vKaNKYj_DJN1xlkarprGpM_fU";

const { VITE_SUPABASE_ANON_KEY, VITE_SUPABASE_URL } = import.meta.env;

console.log({ VITE_SUPABASE_ANON_KEY, VITE_SUPABASE_URL });

export const supabaseClient = createClient(VITE_SUPABASE_URL, VITE_SUPABASE_ANON_KEY, {
  db: {
    schema: "public",
  },
  auth: {
    persistSession: true,
  },
});
