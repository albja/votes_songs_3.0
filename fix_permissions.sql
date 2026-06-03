-- 🔧 SCRIPT CORRECTIF - Répare les permissions des votes
-- 👉 Copie TOUT ce fichier dans Supabase SQL Editor et clique "Run"
--    https://supabase.com/dashboard/project/krmkiivlhlujftbeyjts/sql/new

-- 1) S'assurer que RLS est activé
alter table votes enable row level security;
alter table songs enable row level security;

-- 2) Supprimer les anciennes policies (si elles existent) pour repartir propre
drop policy if exists "public insert votes" on votes;
drop policy if exists "public read votes"   on votes;
drop policy if exists "public read songs"   on songs;

-- 3) Recréer les policies correctement

-- Lecture des morceaux (page de vote)
create policy "public read songs"
on songs for select
to anon, authenticated
using (true);

-- Insertion des votes (quand un client clique)
create policy "public insert votes"
on votes for insert
to anon, authenticated
with check (true);

-- 🔑 LA POLICY QUI MANQUAIT : lecture des votes (dashboard iPad)
create policy "public read votes"
on votes for select
to anon, authenticated
using (true);

-- 🗑️ Suppression des votes (bouton "Réinitialiser" du dashboard)
drop policy if exists "public delete votes" on votes;
create policy "public delete votes"
on votes for delete
to anon, authenticated
using (true);

-- 🔄 SYSTÈME DE TOURS (1 vote par téléphone par tour)
-- Table qui mémorise le numéro du tour courant
create table if not exists app_state (
  id int primary key default 1,
  round int not null default 1
);

-- Insère la ligne unique (si pas déjà présente)
insert into app_state (id, round) values (1, 1)
on conflict (id) do nothing;

alter table app_state enable row level security;

-- Lecture du tour (clients + dashboard)
drop policy if exists "public read state" on app_state;
create policy "public read state"
on app_state for select
to anon, authenticated
using (true);

-- Mise à jour du tour (bouton "Nouveau tour" du dashboard)
drop policy if exists "public update state" on app_state;
create policy "public update state"
on app_state for update
to anon, authenticated
using (true)
with check (true);

-- Active le temps réel sur app_state (pour rouvrir les votes en direct)
do $$
begin
  alter publication supabase_realtime add table app_state;
exception
  when duplicate_object then null;
end $$;

-- 4) S'assurer que le temps réel est actif sur votes (sans erreur si déjà actif)
do $$
begin
  alter publication supabase_realtime add table votes;
exception
  when duplicate_object then null;  -- déjà membre : on ignore
end $$;

-- ✅ C'est réparé ! Les votes vont maintenant s'enregistrer ET remonter au dashboard.
