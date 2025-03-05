FROM node:22.13.1-alpine AS node

WORKDIR /app

RUN apk add --no-cache git

COPY package.json package-lock.json ./

RUN npm ci

ENV NODE_ENV production

COPY . .

RUN npm run build

# ---

FROM ghcr.io/alwatr/nginx-ws:3.5.0

COPY --from=node /app/packages/app/_site/ .
