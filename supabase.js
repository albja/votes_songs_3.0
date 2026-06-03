import { createClient } from "https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm";

// 👇 À remplacer avec tes clés Supabase
const SUPABASE_URL = "https://krmkiivlhlujftbeyjts.supabase.co";
const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtybWtpaXZsaGx1amZ0YmV5anRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODA0NzgxMzYsImV4cCI6MjA5NjA1NDEzNn0.g5smz_NkvqGGC0fm7WeyPXWf_zm0jr1acRw5EtxeDtk";

export const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
