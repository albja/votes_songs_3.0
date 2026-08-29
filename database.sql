-- 🎵 VOTE MUSIC APP - SQL SETUP
-- Copie-colle ce code entier dans Supabase SQL Editor et clique "Run"

-- 1) Table des morceaux
create table songs (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  artist text,
  category text,
  played boolean default false,
  created_at timestamp default now()
);

-- 2) Table des votes
create table votes (
  id uuid default gen_random_uuid() primary key,
  song_id uuid references songs(id) on delete cascade,
  device_id text,
  created_at timestamp default now()
);

-- 2 bis) Table des votants (prénoms saisis le soir du concert)
create table voters (
  device_id text primary key,
  first_name text not null,
  created_at timestamp default now(),
  updated_at timestamp default now()
);

-- 3) Sécurité (Row Level Security)
alter table songs enable row level security;
alter table votes enable row level security;
alter table voters enable row level security;

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

-- Les clients et le dashboard peuvent lire les prénoms enregistrés
create policy "public read voters"
on voters for select
to anon, authenticated
using (true);

-- Les clients peuvent créer / mettre à jour leur prénom
create policy "public insert voters"
on voters for insert
to anon, authenticated
with check (true);

create policy "public update voters"
on voters for update
to anon, authenticated
using (true)
with check (true);

-- Le dashboard peut effacer les prénoms avant un concert
create policy "public delete voters"
on voters for delete
to anon, authenticated
using (true);

-- 5) Active le temps réel (Realtime)
alter publication supabase_realtime add table votes;
alter publication supabase_realtime add table voters;
alter publication supabase_realtime add table songs;

-- 5 bis) Policy UPDATE sur songs (pour toggler "played" depuis le dashboard)
create policy "public update songs"
on songs for update
to anon, authenticated
using (true)
with check (true);

-- 6) Insère la liste finale des morceaux
insert into songs (title, artist) values
('Over the Rainbow / What a Wonderful World', 'Israel Kamakawiwo''ole'),
('The Dock of the Bay', 'Otis Redding'),
('Everything', 'Jehro'),
('Heart of Gold', 'Neil Young'),
('A Horse With No Name', 'America'),
('Enjoy the Silence', 'Depeche Mode'),
('Personal Jesus', 'Depeche Mode'),
('Somebody', 'Depeche Mode'),
('San Francisco', 'Scott McKenzie'),
('Don''t Worry, Be Happy', 'Bobby McFerrin'),
('I''m Yours', 'Jason Mraz'),
('Ho Hey', 'The Lumineers'),
('Isn''t She Lovely', 'Stevie Wonder'),
('Hallelujah', 'Leonard Cohen'),
('The Sound of Silence', 'Simon & Garfunkel'),
('Mrs. Robinson', 'Simon & Garfunkel'),
('Cécilia', 'Simon & Garfunkel'),
('The Scientist', 'Coldplay'),
('Sing', 'Travis'),
('All of Me', 'John Legend'),
('Imagine', 'John Lennon'),
('Sunday with a Flu', 'Yodelice'),
('Five thousand nights', 'Yodelice'),
('Free', 'Yodelice'),
('One', 'U2'),
('Wonderwall', 'Oasis'),
('Champagne Supernova', 'Oasis'),
('Boys Don''t Cry', 'The Cure'),
('Take a Walk on the Wild Side', 'Lou Reed'),
('Losing My Religion', 'R.E.M.'),
('Boulevard of Broken Dreams', 'Green Day'),
('Englishman in New York', 'Sting'),
('Like a Hobo', 'Charlie Winston'),
('Yellow Submarine', 'The Beatles'),
('Let It Be', 'The Beatles'),
('Hey Jude', 'The Beatles'),
('A hard day''s night', 'The Beatles'),
('Yesterday', 'The Beatles'),
('Viva La Vida', 'Coldplay'),
('Radioactive', 'Imagine Dragons'),
('Shallow', 'Lady Gaga & Bradley Cooper'),
('Il y a', 'Vanessa Paradis'),
('La Corrida', 'Francis Cabrel'),
('Petite Marie', 'Francis Cabrel'),
('Les Copains d''abord', 'Georges Brassens'),
('Chanson pour l''Auvergnat', 'Georges Brassens'),
('J''aime les filles', 'Jacques Dutronc'),
('Les Playboys', 'Jacques Dutronc'),
('Sur la route', 'Gérald De Palmas'),
('L''autre Finistère', 'Les Innocents'),
('Soul Man', 'Ben l''Oncle Soul'),
('Je dis aime', '-M-'),
('Mama Sam', '-M-'),
('Quand j''serai K.O.', 'Alain Souchon'),
('La vie ne vaut rien', 'Alain Souchon'),
('L''eau à la bouche', 'Serge Gainsbourg'),
('La Javanaise', 'Serge Gainsbourg'),
('La groupie du pianiste', 'Michel Berger'),
('New York avec toi', 'Téléphone'),
('Le Sud', 'Nino Ferrer'),
('Emmenez moi', 'Charles Aznavour'),
('For me, formidable', 'Charles Aznavour'),
('Armstrong', 'Claude Nougaro'),
('Via Con Me', 'Paolo Conte'),
('Emmène moi', 'Boulevard des Airs'),
('Gabrielle', 'Johnny Hallyday'),
('Je te promets', 'Johnny Hallyday'),
('Les Chant des Sirènes', 'Fréro Delavega'),
('Me Gustas Tú', 'Manu Chao'),
('Clandestino', 'Manu Chao'),
('Rhythm Is Love', 'Keziah Jones'),
('Redemption song', 'Bob Marley'),
('L''hymne de nos campagnes', 'Tryo'),
('Heureux qui comme Ulysse', 'Ridan'),
('Famille', 'Goldman'),
('Natacha', 'Goldman'),
('Champs élysées', 'Joe Dassin'),
('Budapest', 'Georges Ezra'),
('Human', 'Rag''n''Bone Man'),
('Save tonight', 'Eagle-Eye Cherry'),
('Seven nation army', 'The White Stripes'),
('Somewhere only we know', 'Keane'),
('Un beau roman', 'Michel Fugain'),
('Le crocodile', 'Bazbaz'),
('Flowers', 'Miley Cyrus'),
('Hey ya', 'OutKast'),
('A la faveur de l''automne', 'Tété'),
('Sensualité', 'Axelle Red'),
('Stolen dance', 'Milky chance'),
('Temps à nouveau', 'Jean-Louis Aubert'),
('Voilà c''est fini', 'Jean-Louis Aubert'),
('Le métèque', 'George Moustaki');

-- 🎤 C''est bon ! La liste finale est prête.
-- Après avoir nettoyé les anciennes lignes en base, tu peux relancer ce script pour recharger la liste cible.
