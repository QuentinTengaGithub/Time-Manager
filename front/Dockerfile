FROM node:latest

# RUN npm install -g http-server

ARG VUE_APP_BASE_URI

ENV VUE_APP_BASE_URI=$VUE_APP_BASE_URI

WORKDIR /front

COPY package*.json ./

RUN yarn

COPY . .

CMD [ "yarn", "serve", "--port", "7101" ]

# RUN yarn build

# CMD [ "http-server", "dist" ]