############################
# Base + pnpm
############################
FROM node:22-alpine AS base
ENV PNPM_HOME=/pnpm
ENV PATH=$PNPM_HOME:$PATH
RUN corepack enable && corepack prepare pnpm@10.15.1 --activate
# store pnpm stable pour le cache partagé entre stages
RUN pnpm config set store-dir /pnpm/store -g

############################
# deps: préchauffe le store PNPM (cache)
############################
FROM base AS deps
WORKDIR /opt/app
COPY package.json pnpm-lock.yaml ./
# (si tu as un .npmrc / pnpm-workspace.yaml, copie-les aussi ici)
# COPY .npmrc ./
# COPY pnpm-workspace.yaml ./
RUN --mount=type=cache,id=pnpm-store,target=/pnpm/store \
    pnpm fetch

############################
# build: installe toutes les deps + build Strapi (admin) puis PRUNE
############################
# ... (stages base et deps inchangés)

FROM base AS build
WORKDIR /opt/app

RUN apk add --no-cache \
  python3 make g++ pkgconfig \
  autoconf automake libtool nasm \
  zlib-dev libpng-dev vips-dev git

COPY package.json pnpm-lock.yaml ./
# Si tu as un .npmrc (registry privé/mirror), copie-le AVANT
# COPY .npmrc ./

# ✅ Important: préchauffer le store dans CE stage,
# puis installer en offline en s'appuyant sur ce store
RUN --mount=type=cache,id=pnpm-store,target=/pnpm/store \
  pnpm fetch && pnpm install --frozen-lockfile --offline

# puis seulement le code (pour le cache)
COPY . .

ARG NODE_ENV=production
ENV NODE_ENV=$NODE_ENV
ENV STRAPI_TELEMETRY_DISABLED=true
ENV STRAPI_DISABLE_UPDATE_NOTIFICATION=true
RUN pnpm run build

# PRUNE prod
RUN pnpm prune --prod --ignore-scripts


############################
# runtime: image finale minimale
############################
FROM node:22-alpine AS runtime

# sharp (Strapi upload) nécessite la lib runtime
RUN apk add --no-cache vips curl

ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=1337
ENV STRAPI_TELEMETRY_DISABLED=true
ENV STRAPI_DISABLE_UPDATE_NOTIFICATION=true

WORKDIR /opt/app

# On copie directement depuis "build" : node_modules PRUNÉ + code buildé
COPY --from=build --chown=node:node /opt/app/node_modules ./node_modules
COPY --from=build --chown=node:node /opt/app ./

USER node
EXPOSE 1337

# Démarrage Strapi (choisis l'un des deux)
# CMD ["pnpm", "start"]
CMD ["node", "server.js"]
