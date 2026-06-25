-- Migration : ajouter la colonne "played" à la table songs
-- À exécuter dans le SQL Editor de Supabase

-- 1) Ajouter la colonne played (défaut false)
ALTER TABLE songs ADD COLUMN IF NOT EXISTS played BOOLEAN DEFAULT false;

-- 2) Ajouter la table songs à la publication Realtime
-- (pour que les changements soient diffusés en temps réel)
ALTER PUBLICATION supabase_realtime ADD TABLE songs;

-- 3) Policy UPDATE sur songs (pour que le dashboard puisse toggler played)
CREATE POLICY "Allow public update on songs"
  ON songs FOR UPDATE
  USING (true)
  WITH CHECK (true);
