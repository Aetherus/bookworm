FROM node:10.19.0-alpine3.9

WORKDIR /app

COPY package.json package.json
COPY package-lock.json package-lock.json
RUN npm install

COPY public public
COPY src src
COPY .browserslistrc .browserslistrc
COPY .env .env
COPY .eslintrc.js .eslintrc.js
COPY babel.config.js babel.config.js

EXPOSE 8080

CMD npm run serve

