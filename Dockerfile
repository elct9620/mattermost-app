FROM ubuntu:14.04

ENV MATTERMOST_VERSION 3.7.1

RUN apt-get update && apt-get -y install curl netcat pwgen
RUN mkdir -p /mattermost/data

RUN curl https://releases.mattermost.com/$MATTERMOST_VERSION/mattermost-team-$MATTERMOST_VERSION-linux-amd64.tar.gz | tar -xvz

RUN rm /mattermost/config/config.json
COPY config.template.json /

COPY docker-entry.sh /
RUN chmod +x /docker-entry.sh
ENTRYPOINT ["/docker-entry.sh"]

VOLUME /mattermost/data
WORKDIR /mattermost/bin

EXPOSE 80
