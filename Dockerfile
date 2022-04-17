# Stage 1
FROM node:alpine3.18 as build-stage

WORKDIR /app

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build

# Stage 2
FROM nginx:1.23

COPY --from=build-stage /app/dist /usr/share/nginx/html

CMD nginx -g 'daemon off;'