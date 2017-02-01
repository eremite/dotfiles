# docker build -t apex -f dockerfiles/apex.dockerfile .
FROM alpine:3.3
RUN apk add --update curl \
  && rm -rf /var/cache/apk/* \
  && curl https://raw.githubusercontent.com/apex/apex/master/install.sh | sh
