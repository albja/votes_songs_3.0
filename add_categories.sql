-- 🎵 AJOUT DES CATÉGORIES AUX CHANSONS
-- Copie ce fichier dans Supabase SQL Editor et clique "Run"

-- 1) Ajouter la colonne category si elle n'existe pas
alter table songs add column if not exists category text;

-- 2) Assigner les catégories

-- 🌴 Folk / Acoustic / Feel Good
update songs set category = '🌴 Folk / Acoustic' where title in (
  'Over the Rainbow / What a Wonderful World',
  'Everything',
  'Heart of Gold',
  'A Horse With No Name',
  'Don''t Worry, Be Happy',
  'I''m Yours',
  'Ho Hey',
  'Hallelujah',
  'Like a Hobo',
  'Sunday with a Flu'
);

-- 🎸 Rock Anglais
update songs set category = '🎸 Rock Anglais' where title in (
  'Wonderwall',
  'Champagne Supernova',
  'Boys Don''t Cry',
  'Personal Jesus',
  'Enjoy the Silence',
  'Losing My Religion',
  'Boulevard of Broken Dreams',
  'Radioactive',
  'One',
  'With or Without You'
);

-- 🎹 Pop Anglaise
update songs set category = '🎹 Pop Anglaise' where title in (
  'The Scientist',
  'Viva La Vida',
  'Sing',
  'All of Me',
  'Imagine',
  'Shallow',
  'Yellow Submarine',
  'Let It Be',
  'Hey Jude',
  'Isn''t She Lovely'
);

-- 🎷 Soul / Funk / Groove
update songs set category = '🎷 Soul / Funk' where title in (
  'The Dock of the Bay',
  'San Francisco',
  'The Sound of Silence',
  'Mrs. Robinson',
  'Englishman in New York',
  'Take a Walk on the Wild Side',
  'Rhythm Is Love'
);

-- 🇫🇷 Chanson Française
update songs set category = '🇫🇷 Chanson Française' where title in (
  'Il y a',
  'La Corrida',
  'Les Copains d''abord',
  'Les Playboys',
  'Sur la route',
  'L''autre Finistère',
  'Je dis aime',
  'Mama Sam',
  'Quand j''serai K.O.',
  'L''eau à la bouche',
  'La Javanaise',
  'La groupie du pianiste',
  'New York avec toi',
  'Le Sud',
  'Emmenezmoi',
  'For me, formidable',
  'Armstrong',
  'Via Con Me',
  'Emmènemoi',
  'Gabrielle',
  'Je te promets',
  'Les Chant des Sirènes',
  'Me Gustas Tú'
);

-- ✅ Vérification : tout ce qui n'a pas de catégorie sera affiché dans "Autres"
-- select title, category from songs order by category, title;
