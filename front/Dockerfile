FROM node:8.16.0-alpine
WORKDIR /usr/src/app

ADD ./package.json /usr/src/app/package.json

RUN npm install --save prop-types
RUN npm install -g create-react-app

ADD . /usr/src/app