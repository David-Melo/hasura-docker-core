FROM node:lts

ARG NODE_ENV=production

ENV NODE_ENV=$NODE_ENV

RUN npm install typescript ts-node sails -g

WORKDIR /opt/app