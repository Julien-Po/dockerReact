FROM node:20-alpine3.17 as BUILD_IMAGE
WORKDIR /src/

COPY package.json .

RUN npm install 

COPY . . 

RUN npm run build 



FROM node:20-alpine3.17 as PRODUCTION_IMAGE
WORKDIR /src/

COPY --from=BUILD_IMAGE /src/dist/ /src/dist/
EXPOSE 8080 

COPY package.json .
COPY vite.config.js .
EXPOSE 8080
CMD ["npm", "run", "preview"]