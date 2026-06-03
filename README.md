# 🎵 Vote Music App

Système de vote en temps réel pour musiciens en concert (bar, événement, etc.)

## 📋 Ce qu'il y a dedans

- **index.html** → Page de vote (clients scannent QR code)
- **dashboard.html** → Dashboard iPad live (musicien voit les votes en temps réel)
- **supabase.js** → Connexion centralisée à la base de données

## 🚀 Installation rapide

### 1️⃣ Créer un compte Supabase (gratuit)
- Va sur https://supabase.com → Sign up
- Crée un projet
- Va dans "Settings" → "API" et copie :
  - **Project URL** → `SUPABASE_URL`
  - **anon public** → `SUPABASE_ANON_KEY`

### 2️⃣ Configurer la base de données
- Va dans "SQL Editor" (dans Supabase)
- Copie-colle le code ci-dessous et clique "Run"

```sql
create table songs (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  artist text,
  created_at timestamp default now()
);

create table votes (
  id uuid default gen_random_uuid() primary key,
  song_id uuid references songs(id) on delete cascade,
  created_at timestamp default now()
);

alter table songs enable row level security;
alter table votes enable row level security;

create policy "public read songs"
on songs for select using (true);

create policy "public insert votes"
on votes for insert with check (true);

alter publication supabase_realtime add table votes;

-- Insérer les 5 morceaux
insert into songs (title, artist) values
('Song 1', 'Artist A'),
('Song 2', 'Artist B'),
('Song 3', 'Artist C'),
('Song 4', 'Artist D'),
('Song 5', 'Artist E');
```

### 3️⃣ Remplir tes clés dans supabase.js
Ouvre `supabase.js` et remplace :
```javascript
const SUPABASE_URL = "https://YOUR_PROJECT.supabase.co";
const SUPABASE_ANON_KEY = "YOUR_ANON_KEY";
```

Par tes vraies clés (depuis Supabase → Settings → API)

### 4️⃣ Déployer gratuitement
**Option A : Vercel (recommandé)**
- https://vercel.com/new → importe ce dossier depuis GitHub
- Clique "Deploy"
- Reçois une URL publique

**Option B : Netlify**
- https://netlify.com → "Add new site" → Upload folder
- Même process

**Option C : Local (pour tester)**
- Télécharge un simple serveur HTTP local
- Ou ouvre les fichiers HTML directement

## 🎤 Utilisation en concert

### 📱 Côté client (vote)
1. Imprime un QR code qui pointe vers ton `index.html`
2. Mets-le sur les tables
3. Les clients scannent → votent
4. Aucun compte, aucune connexion partagée ✅

### 📊 Côté toi (iPad)
1. Ouvre `dashboard.html` sur ton iPad
2. Les votes apparaissent **en direct** (live update)
3. Tu vois le classement en temps réel
4. Pas besoin de refresh manuel ✅

## 👤 Prénoms des votants (soir de concert)

- Sur la page de vote, chaque personne saisit son **prénom** (mémorisé sur son téléphone).
- Le prénom s'affiche en direct sous chaque morceau dans le **dashboard**.
- Le bouton **🔄 Nouveau tour** rouvre les votes **sans** effacer le prénom côté votant.
- Le bouton **🧹 Effacer les prénoms** (dashboard) vide la table `voters` sans toucher aux votes.

> ⚠️ **Mise à jour base de données obligatoire** : exécute à nouveau `fix_permissions.sql`
> dans Supabase (SQL Editor) pour créer la table `voters`, ses policies et la colonne
> `device_id` sur `votes`.

## 🔧 Personnalisation

### Changer les 5 morceaux
Va dans Supabase → Table "songs" → Edit rows
- Remplace "Song 1", "Artist A", etc. par tes vraies chansons

### Ajouter plus de chansons
Dans Supabase SQL Editor :
```sql
insert into songs (title, artist) values ('Ma chanson', 'Mon nom');
```

### Modifier le design
- **index.html** → modifie les couleurs/polices dans `<style>`
- **dashboard.html** → même chose

## 🎨 Bonus : rendre ça ultra pro

Si tu veux aller plus loin :
- Ajouter des emojis aux chansons
- Animer les barres en temps réel
- Afficher le top 1 en ÉNORME sur le dashboard
- Anti multi-vote par appareil
- Mode "mode sombre" pour le concert

Demande si tu veux que j'ajoute ça ! 🎸

## 📞 Troubleshooting

**Les votes ne s'affichent pas ?**
- Vérifie tes clés Supabase (copy-paste exact)
- Regarde la console (F12 → Console) pour les erreurs

**Ça dit "Erreur de connexion" ?**
- Vérifie que tu es en ligne
- Essaye sur un autre téléphone (Wi-Fi différent)

**Trop lent / lag ?**
- C'est normal en Wi-Fi faible → c'est du temps réel
- Supabase a 1-2 secondes de latence habituel

**Veux-tu ajouter une vraie connexion serveur ?**
- C'est possible avec Node.js / Express
- Demande si tu veux qu'on le fasse

---

**Made for musicians who don't want complicated shit.** 🎤🎸
