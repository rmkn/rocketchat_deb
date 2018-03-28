FROM debian:stable-slim
MAINTAINER rmkn

RUN apt-get update
RUN apt-get install -y mongodb curl graphicsmagick gnupg
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g n
RUN n 8.9.3

RUN curl -SL https://releases.rocket.chat/latest/download -o /tmp/rocket.chat.tgz \
        && tar zxf /tmp/rocket.chat.tgz -C /usr/local \
        && mv /usr/local/bundle /usr/local/Rocket.Chat

WORKDIR /usr/local/Rocket.Chat/programs/server
RUN npm install
#WORKDIR /usr/local/Rocket.Chat/programs/server/npm/node_modules
#RUN npm rebuild sharp

ENV PORT 80
ENV ROOT_URL http://localhost/
ENV MONGO_URL mongodb://localhost:27017/rocketchat

COPY entrypoint.sh /

##VOLUME /data/db
RUN mkdir -p /data/db && chmod 777 /data/db
EXPOSE 80

CMD ["node", "/usr/local/Rocket.Chat/main.js"]

ENTRYPOINT ["/entrypoint.sh"]

