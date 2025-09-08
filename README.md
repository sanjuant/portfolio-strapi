# Portfolio Strapi Backend

Un CMS headless Strapi 5.23.1 conçu pour alimenter un site portfolio moderne avec support multilingue et intégration Cloudinary.

## 🚀 Fonctionnalités

- **CMS Headless** : API REST complète pour frontend découplé
- **Multilingue** : Support i18n pour contenu localisé
- **Gestion d'images** : Intégration Cloudinary pour stockage optimisé
- **Éditeur riche** : CKEditor pour création de contenu avancée
- **Base de données flexible** : Support PostgreSQL, MySQL et SQLite
- **Docker Ready** : Configuration multi-étages optimisée pour production

## 📁 Types de Contenu

### Types Uniques (Single Types)
- **Hero** : Section d'accueil avec animation typewriter et CV
- **About Me** : Page à propos avec contenu riche et recommandations
- **Contact** : Informations de contact et liens sociaux
- **Identity** : Identité personnelle et compétences comportementales

### Collections
- **Portfolio** : Projets avec images, descriptions et catégories
- **Skills** : Compétences techniques avec logos et niveaux
- **Education & Training** : Parcours académique et formations
- **Professional Experience** : Expériences professionnelles

## 🛠️ Installation

### Prérequis
- Node.js 18+ 
- pnpm (recommandé) ou npm
- PostgreSQL (production) ou SQLite (développement)

### Configuration locale

1. **Cloner le projet**
   ```bash
   git clone <repository-url>
   cd portfolio-strapi
   ```

2. **Installer les dépendances**
   ```bash
   pnpm install
   # ou
   npm install
   ```

3. **Configuration environnement**
   ```bash
   cp .env.example .env
   ```
   Éditer `.env` avec vos configurations :
   ```bash
   # Base de données
   DATABASE_CLIENT=postgres  # ou sqlite pour dev local
   DATABASE_HOST=localhost
   DATABASE_PORT=5432
   DATABASE_NAME=strapi
   DATABASE_USERNAME=strapi
   DATABASE_PASSWORD=strapi

   # Secrets (générer des valeurs uniques)
   APP_KEYS=key1,key2,key3,key4
   API_TOKEN_SALT=your_salt
   ADMIN_JWT_SECRET=your_secret
   JWT_SECRET=your_jwt_secret
   TRANSFER_TOKEN_SALT=your_transfer_salt

   # Cloudinary
   CLOUDINARY_NAME=your_cloud_name
   CLOUDINARY_KEY=your_api_key
   CLOUDINARY_SECRET=your_secret
   ```

4. **Démarrer en développement**
   ```bash
   pnpm run dev
   # ou
   npm run dev
   ```

## 📋 Commandes Disponibles

### Développement
```bash
pnpm run dev          # Serveur développement avec rechargement auto
pnpm run develop      # Alias pour dev
pnpm run start        # Serveur production
pnpm run build        # Build de l'interface admin
```

### Base de données
```bash
pnpm run console      # Console Strapi
pnpm run strapi       # Accès CLI Strapi direct
```

### Maintenance
```bash
pnpm run upgrade      # Mise à jour Strapi
pnpm run upgrade:dry  # Vérifier les mises à jour disponibles
```

## 🐳 Déploiement Docker

### Build et démarrage
```bash
# Build de l'image
docker build -t portfolio-strapi .

# Démarrage avec variables d'environnement
docker run -p 1337:1337 --env-file .env portfolio-strapi
```

### Configuration Docker avancée
Le Dockerfile utilise une approche multi-étapes :
- **Base** : Node.js 22 Alpine avec pnpm
- **Dependencies** : Cache des dépendances
- **Build** : Compilation avec dépendances natives
- **Runtime** : Image finale minimale

## 🌐 API Endpoints

### Types Uniques
- `GET /api/hero` - Section hero
- `GET /api/about-me` - Page à propos  
- `GET /api/contact` - Informations contact
- `GET /api/identity` - Identité personnelle

### Collections (CRUD complet)
- `GET|POST /api/portfolios` - Projets portfolio
- `GET|POST /api/skills` - Compétences techniques
- `GET|POST /api/educations-and-trainings` - Formations
- `GET|POST /api/professionnal-experiences` - Expériences

### Fonctionnalités API
- **Populate Deep** : Requêtes imbriquées jusqu'à 5 niveaux
- **Filtrage** : Capacités de filtrage avancées
- **Tri** : Options de tri configurables
- **Pagination** : Pagination automatique pour collections

## 🔧 Configuration

### Base de données
Support multi-base via `config/database.ts` :
- PostgreSQL (recommandé production)
- MySQL 
- SQLite (développement)

### Plugins
- **Upload Cloudinary** : Stockage d'images optimisé
- **Populate Deep** : Requêtes relationnelles avancées
- **i18n** : Internationalisation
- **CKEditor** : Éditeur de contenu riche

### Sécurité
- Gestion des secrets via variables d'environnement
- Configuration CORS adaptable
- Validation automatique des données
- Système de permissions granulaire

## 📱 Interface Admin

Accès : `http://localhost:1337/admin`

### Première utilisation
1. Créer un compte administrateur
2. Configurer les types de contenu
3. Paramétrer les plugins
4. Créer le contenu initial

## 🚀 Production

### Variables d'environnement production
```bash
NODE_ENV=production
DATABASE_CLIENT=postgres
DATABASE_URL=your_postgres_url
CLOUDINARY_NAME=your_production_cloud
# ... autres secrets
```

### Optimisations
- Build optimisé avec pruning des dépendances
- Images Docker multi-étapes
- Configuration SSL pour base de données
- Cache et compression activés

## 🤝 Développement

### Structure du projet
```
src/
├── api/                    # Types de contenu
│   ├── hero/              # Section hero
│   ├── portfolio/         # Projets
│   ├── skills/            # Compétences
│   └── ...
├── components/            # Composants réutilisables
└── extensions/           # Extensions personnalisées

config/                   # Configurations
├── database.ts          # Base de données
├── plugins.ts           # Plugins
└── ...
```

### Cycle de vie
- Hooks de cycle de vie dans `src/api/*/content-types/*/lifecycles.ts`
- Contrôleurs personnalisés dans `src/api/*/controllers/`
- Services dans `src/api/*/services/`

## 📄 Licence

[Préciser la licence du projet]

## 🆘 Support

Pour signaler des bugs ou demander des fonctionnalités, créer une issue dans le repository.