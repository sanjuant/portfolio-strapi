# ---------- 1) DEPS DEV (pour build) ----------
FROM node:22-alpine AS deps-dev
RUN apk add --no-cache python3 make g++ autoconf automake zlib-dev libpng-dev vips-dev git
RUN corepack enable && corepack prepare pnpm@10.15.1 --activate
WORKDIR /opt/app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

# ---------- 2) BUILD (admin + ts) ----------
FROM deps-dev AS build
WORKDIR /opt/app
COPY . .
ENV NODE_ENV=development
RUN pnpm build

# ---------- 3) DEPS PROD (runtime only) ----------
FROM node:22-alpine AS deps-prod
RUN corepack enable && corepack prepare pnpm@10.15.1 --activate
WORKDIR /opt/app
COPY package.json pnpm-lock.yaml ./
# ⬇️ évite sqlite/better-sqlite3 si tu es en Postgres
RUN pnpm install --prod --frozen-lockfile --no-optional

# ---------- 4) RUNTIME (léger) ----------
FROM node:22-alpine AS runner
RUN apk add --no-cache vips
ENV NODE_ENV=production HOST=0.0.0.0 PORT=1337
WORKDIR /opt/app

# Copie ciblée + ownership direct (évite un chown -R très coûteux)
COPY --from=deps-prod --chown=node:node /opt/app/node_modules ./node_modules
COPY --from=build     --chown=node:node /opt/app ./

USER node
EXPOSE 1337
CMD ["./node_modules/.bin/strapi", "start"]
