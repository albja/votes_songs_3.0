-- 🎵 ACTUALISER LA LISTE DES CHANSONS AVEC CATÉGORIES
-- Copie ce fichier dans Supabase SQL Editor et clique "Run"
-- Ce script :
-- 1) met à jour la catégorie des chansons existantes
-- 2) ajoute les chansons manquantes
-- 3) garde les chansons non listées (suppression optionnelle en bas)

begin;

alter table songs add column if not exists category text;

create temp table incoming_songs (
  title text not null,
  artist text,
  category text not null
) on commit drop;

-- 🌴 Folk / Acoustic
insert into incoming_songs (title, artist, category)
select v.title, v.artist, '🌴 Folk / Acoustic'
from (
  values
    ('Over the Rainbow / What a Wonderful World', 'Israel Kamakawiwo''ole'),
    ('Everything', 'Jehro'),
    ('Heart of Gold', 'Neil Young'),
    ('A Horse With No Name', 'America'),
    ('Don''t Worry, Be Happy', 'Bobby McFerrin'),
    ('I''m Yours', 'Jason Mraz'),
    ('Ho Hey', 'The Lumineers'),
    ('Hallelujah', 'Leonard Cohen'),
    ('The Sound of Silence', 'Simon & Garfunkel'),
    ('Mrs. Robinson', 'Simon & Garfunkel'),
    ('Cécilia', 'Simon & Garfunkel'),
    ('Sunday with a Flu', 'Yodelice'),
    ('Five thousand nights', 'Yodelice'),
    ('Free', 'Yodelice'),
    ('Like a Hobo', 'Charlie Winston'),
    ('Budapest', 'Georges Ezra'),
    ('Save tonight', 'Eagle-Eye Cherry'),
    ('Somewhere only we know', 'Keane'),
    ('Stolen dance', 'Milky chance'),
    ('A la faveur de l''automne', 'Tété')
) as v(title, artist);

-- 🎸 Rock Anglais
insert into incoming_songs (title, artist, category)
select v.title, v.artist, '🎸 Rock Anglais'
from (
  values
    ('Enjoy the Silence', 'Depeche Mode'),
    ('Personal Jesus', 'Depeche Mode'),
    ('Somebody', 'Depeche Mode'),
    ('One', 'U2'),
    ('Wonderwall', 'Oasis'),
    ('Champagne Supernova', 'Oasis'),
    ('Boys Don''t Cry', 'The Cure'),
    ('Losing My Religion', 'R.E.M.'),
    ('Boulevard of Broken Dreams', 'Green Day'),
    ('Radioactive', 'Imagine Dragons'),
    ('Seven nation army', 'The White Stripes')
) as v(title, artist);

-- 🎹 Pop Anglaise
insert into incoming_songs (title, artist, category)
select v.title, v.artist, '🎹 Pop Anglaise'
from (
  values
    ('The Scientist', 'Coldplay'),
    ('Sing', 'Travis'),
    ('All of Me', 'John Legend'),
    ('Imagine', 'John Lennon'),
    ('Isn''t She Lovely', 'Stevie Wonder'),
    ('Yellow Submarine', 'The Beatles'),
    ('Let It Be', 'The Beatles'),
    ('Hey Jude', 'The Beatles'),
    ('A hard day''s night', 'The Beatles'),
    ('Yesterday', 'The Beatles'),
    ('Viva La Vida', 'Coldplay'),
    ('Shallow', 'Lady Gaga & Bradley Cooper'),
    ('Human', 'Rag''n''Bone Man'),
    ('Flowers', 'Miley Cyrus'),
    ('Hey ya', 'OutKast')
) as v(title, artist);

-- 🎷 Soul / Funk
insert into incoming_songs (title, artist, category)
select v.title, v.artist, '🎷 Soul / Funk'
from (
  values
    ('The Dock of the Bay', 'Otis Redding'),
    ('San Francisco', 'Scott McKenzie'),
    ('Take a Walk on the Wild Side', 'Lou Reed'),
    ('Englishman in New York', 'Sting'),
    ('Soul Man', 'Ben l''Oncle Soul'),
    ('Rhythm Is Love', 'Keziah Jones'),
    ('Sensualité', 'Axelle Red')
) as v(title, artist);

-- 🇫🇷 Chanson Française
insert into incoming_songs (title, artist, category)
select v.title, v.artist, '🇫🇷 Chanson Française'
from (
  values
    ('Il y a', 'Vanessa Paradis'),
    ('La Corrida', 'Francis Cabrel'),
    ('Petite Marie', 'Francis Cabrel'),
    ('Les Copains d''abord', 'Georges Brassens'),
    ('Chanson pour l''Auvergnat', 'Georges Brassens'),
    ('J''aime les filles', 'Jacques Dutronc'),
    ('Les Playboys', 'Jacques Dutronc'),
    ('Sur la route', 'Gérald De Palmas'),
    ('L''autre Finistère', 'Les Innocents'),
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
    ('L''hymne de nos campagnes', 'Tryo'),
    ('Heureux qui comme Ulysse', 'Ridan'),
    ('Famille', 'Goldman'),
    ('Natacha', 'Goldman'),
    ('Champs élysées', 'Joe Dassin'),
    ('Un beau roman', 'Michel Fugain'),
    ('Le crocodile', 'Bazbaz'),
    ('Temps à nouveau', 'Jean-Louis Aubert'),
    ('Voilà c''est fini', 'Jean-Louis Aubert'),
    ('Le métèque', 'George Moustaki')
) as v(title, artist);

-- 🌍 World / Reggae
insert into incoming_songs (title, artist, category)
select v.title, v.artist, '🌍 World / Reggae'
from (
  values
    ('Me Gustas Tú', 'Manu Chao'),
    ('Clandestino', 'Manu Chao'),
    ('Redemption song', 'Bob Marley')
) as v(title, artist);

-- Contrôle attendu: 92 morceaux
-- select count(*) from incoming_songs;

-- 1) Met à jour la catégorie des titres existants
update songs s
set category = i.category
from incoming_songs i
where s.title = i.title
  and coalesce(s.artist, '') = coalesce(i.artist, '');

-- 2) Ajoute les titres qui n'existent pas encore
insert into songs (title, artist, category, played)
select i.title, i.artist, i.category, false
from incoming_songs i
where not exists (
  select 1
  from songs s
  where s.title = i.title
    and coalesce(s.artist, '') = coalesce(i.artist, '')
);

-- 3) Optionnel: supprimer les chansons absentes de la nouvelle liste
-- ⚠️ Décommente uniquement si tu veux vraiment nettoyer la base.
-- delete from songs s
-- where not exists (
--   select 1
--   from incoming_songs i
--   where i.title = s.title
--     and coalesce(i.artist, '') = coalesce(s.artist, '')
-- );

commit;

-- Vérification rapide
-- select category, count(*) from songs group by category order by category;
-- select title, artist, category from songs order by category, title;
