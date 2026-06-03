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
('Over the Rainbow / What a Wonderful World', 'Israel Kamakawiwo''ole'),
('The Dock of the Bay', 'Otis Redding'),
('Everything', 'Jehro'),
('Heart of Gold', 'Neil Young'),
('A Horse With No Name', 'America'),
('Enjoy the Silence', 'Depeche Mode'),
('San Francisco', 'Scott McKenzie'),
('Don''t Worry, Be Happy', 'Bobby McFerrin'),
('I''m Yours', 'Jason Mraz'),
('Ho Hey', 'The Lumineers'),
('Isn''t She Lovely', 'Stevie Wonder'),
('Hallelujah', 'Leonard Cohen'),
('The Sound of Silence', 'Simon & Garfunkel'),
('The Scientist', 'Coldplay'),
('Sing', 'Travis'),
('All of Me', 'John Legend'),
('Imagine', 'John Lennon'),
('Sunday with a Flu', 'Yodelice'),
('One', 'U2'),
('With or Without You', 'U2'),
('Mrs. Robinson', 'Simon & Garfunkel'),
('Wonderwall', 'Oasis'),
('Champagne Supernova', 'Oasis'),
('Boys Don''t Cry', 'The Cure'),
('Take a Walk on the Wild Side', 'Lou Reed'),
('Personal Jesus', 'Depeche Mode'),
('Losing My Religion', 'R.E.M.'),
('Boulevard of Broken Dreams', 'Green Day'),
('Englishman in New York', 'Sting'),
('Like a Hobo', 'Charlie Winston'),
('Yellow Submarine', 'The Beatles'),
('Let It Be', 'The Beatles'),
('Hey Jude', 'The Beatles'),
('Viva La Vida', 'Coldplay'),
('Radioactive', 'Imagine Dragons'),
('Shallow', 'Lady Gaga & Bradley Cooper'),
('Il y a', 'Vanessa Paradis'),
('La Corrida', 'Francis Cabrel'),
('Les Copains d''abord', 'Georges Brassens'),
('Les Playboys', 'Jacques Dutronc'),
('Sur la route', 'Gérald De Palmas'),
('L''autre Finistère', 'Les Innocents'),
('Je dis aime', '-M-'),
('Mama Sam', '-M-'),
('Quand j''serai K.O.', 'Alain Souchon'),
('L''eau à la bouche', 'Serge Gainsbourg'),
('La Javanaise', 'Serge Gainsbourg'),
('La groupie du pianiste', 'Michel Berger'),
('New York avec toi', 'Téléphone'),
('Le Sud', 'Nino Ferrer'),
('Emmenezmoi', 'Charles Aznavour'),
('For me, formidable', 'Charles Aznavour'),
('Armstrong', 'Claude Nougaro'),
('Via Con Me', 'Paolo Conte'),
('Emmènemoi', 'Boulevard des Airs'),
('Gabrielle', 'Johnny Hallyday'),
('Je te promets', 'Johnny Hallyday'),
('Les Chant des Sirènes', 'Fréro Delavega'),
('Me Gustas Tú', 'Manu Chao'),
('Rhythm Is Love', 'Keziah Jones');

-- 🎤 C'est bon ! Tes tables sont prêtes.
-- Remplace "Song 1", "Artist A", etc. par tes vraies chansons.
