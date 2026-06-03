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
on songs for select
to anon, authenticated
using (true);

-- Les clients peuvent voter (insertion)
create policy "public insert votes"
on votes for insert
to anon, authenticated
with check (true);

-- Le dashboard peut lire les votes (lecture)
create policy "public read votes"
on votes for select
to anon, authenticated
using (true);

-- 5) Active le temps réel (Realtime)
alter publication supabase_realtime add table votes;

-- 6) Insère les 5 morceaux
insert into songs (title, artist) values
('Bohemian Rhapsody', 'Queen'),
('Billie Jean', 'Michael Jackson'),
('Smells Like Teen Spirit', 'Nirvana'),
('Hotel California', 'Eagles'),
('Stairway to Heaven', 'Led Zeppelin'),
('Like a Rolling Stone', 'Bob Dylan'),
('Purple Haze', 'Jimi Hendrix'),
('Johnny B. Goode', 'Chuck Berry'),
('What''s Going On', 'Marvin Gaye'),
('Respect', 'Aretha Franklin'),
('Born to Run', 'Bruce Springsteen'),
('Superstition', 'Stevie Wonder'),
('Lose Yourself', 'Eminem'),
('Bitter Sweet Symphony', 'The Verve'),
('Wonderwall', 'Oasis'),
('Under the Bridge', 'Red Hot Chili Peppers'),
('Mr. Brightside', 'The Killers'),
('Rolling in the Deep', 'Adele'),
('Blinding Lights', 'The Weeknd'),
('Bad Guy', 'Billie Eilish');

-- 🎤 C'est bon ! Tes tables sont prêtes.
-- Remplace "Song 1", "Artist A", etc. par tes vraies chansons.
