-- 🎵 VOTE MUSIC APP - SQL SETUP
-- Copie-colle ce code entier dans Supabase SQL Editor et clique "Run"

-- 1) Table des morceaux
create table songs (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  artist text,
  created_at timestamp default now()
);

-- 2) Table des votes
create table votes (
  id uuid default gen_random_uuid() primary key,
  song_id uuid references songs(id) on delete cascade,
  created_at timestamp default now()
);

-- 3) Sécurité (Row Level Security)
alter table songs enable row level security;
alter table votes enable row level security;

-- 4) Permissions
-- Les clients peuvent voir les morceaux
create policy "public read songs"
on songs for select using (true);

-- Les clients peuvent voter
create policy "public insert votes"
on votes for insert with check (true);

-- 5) Active le temps réel (Realtime)
alter publication supabase_realtime add table votes;

-- 6) Insère les 5 morceaux
insert into songs (title, artist) values
('Song 1', 'Artist A'),
('Song 2', 'Artist B'),
('Song 3', 'Artist C'),
('Song 4', 'Artist D'),
('Song 5', 'Artist E');

-- 🎤 C'est bon ! Tes tables sont prêtes.
-- Remplace "Song 1", "Artist A", etc. par tes vraies chansons.
