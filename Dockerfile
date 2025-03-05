FROM node:22.13.1-alpine AS node

WORKDIR /app

ENV NODE_ENV production

RUN apk add --no-cache git

COPY package.json package-lock.json ./

RUN npm ci

COPY . .

RUN npm run build

# ---

FROM ghcr.io/alwatr/nginx-ws:3.5.0

COPY --from=node /app/packages/app/_site/ .
