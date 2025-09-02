# =========================
# 1) BUILD (avec dev deps)
# =========================
FROM node:22-alpine AS build

# Outils nécessaires pour compiler les modules natifs (sharp, etc.)
RUN apk add --no-cache \
    python3 make g++ \
    autoconf automake zlib-dev libpng-dev \
    vips-dev git

# Améliore la robustesse réseau des installs
RUN npm config set fetch-retry-maxtimeout 600000 -g

# Code + deps
WORKDIR /opt/app
COPY package.json package-lock.json ./
RUN npm ci

# Copie du projet puis build Strapi (admin + server)
COPY . .
RUN npm run build

# On retire les devDependencies pour préparer l'image finale
RUN npm prune --omit=dev


# =========================
# 2) RUNTIME (production)
# =========================
FROM node:22-alpine

# Dépendance runtime pour sharp (pas besoin de *-dev)
RUN apk add --no-cache vips

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV} \
    HOST=0.0.0.0 \
    PORT=1337

WORKDIR /opt/app

# On récupère le code *et* les node_modules déjà prunés
COPY --from=build /opt/app ./

# Dossier uploads + droits
RUN mkdir -p ./public/uploads \
 && chown -R node:node /opt/app
USER node

EXPOSE 1337
CMD ["npm", "run", "start"]
