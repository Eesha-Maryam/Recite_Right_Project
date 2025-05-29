// src/supabaseClient.js

import { createClient } from '@supabase/supabase-js';

// Replace these with your actual Supabase credentials
const SUPABASE_URL = 'https://your-project-id.supabase.co'; // replace with your Supabase URL
const SUPABASE_ANON_KEY = 'your-anon-key'; // replace with your Supabase Anon Key

// Create a Supabase client
export const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
