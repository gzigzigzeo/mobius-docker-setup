FROM stellar/base:latest

MAINTAINER Viktor Sokolov <gzigzigzeo@evilmartians.com>

# Dependencies
RUN apt-get update
RUN apt-get install -y curl git libpq-dev libsqlite3-dev libsasl2-dev postgresql-client vim zlib1g-dev rpl
RUN apt-get clean

# stellar-core ports
EXPOSE 11625
EXPOSE 11626

# Settings
ENV STELLAR_CORE_VERSION 0.6.3-391-708237b0
ENV DATABASE_URL "user=gzigzigzeo host=localhost dbname=core"
ENV NETWORK "testnet"
ENV STELLAR_DEB_URL "https://s3.amazonaws.com/stellar.org/releases/stellar-core/stellar-core-${STELLAR_CORE_VERSION}_amd64.deb"

# Installation
RUN wget -O stellar-core.deb $STELLAR_DEB_URL
RUN dpkg -i stellar-core.deb
RUN rm stellar-core.deb

# Root dir
RUN mkdir -p /opt/stellar/etc
RUN mkdir -p /opt/stellar/etc/default
RUN mkdir -p /opt/stellar/history-cache

# Config files
ADD pubnet /opt/stellar/etc/default/pubnet
ADD testnet /opt/stellar/etc/default/testnet

# Entrypoint
ADD start.sh /
RUN chmod +x start.sh

ENTRYPOINT /start.sh
