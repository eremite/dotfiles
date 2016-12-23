# docker build -t serverless -f dockerfiles/serverless.dockerfile .
FROM node:4.6.2-alpine
MAINTAINER Custom Bit <info@custombit.com>

RUN npm install -g serverless

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
