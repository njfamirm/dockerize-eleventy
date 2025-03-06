# Build Stage
FROM node:22-alpine AS node

WORKDIR /app

ENV NODE_ENV=production

RUN apk add --no-cache git

COPY package.json package-lock.json ./

RUN npm ci --include=dev

COPY . .

RUN npm run build

# Serve Stage
FROM ghcr.io/alwatr/nginx-ws:3.5.0

COPY --from=node /app/_site/ .
