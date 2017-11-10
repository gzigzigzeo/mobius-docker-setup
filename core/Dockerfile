FROM stellar/base:latest

MAINTAINER Viktor Sokolov <gzigzigzeo@evilmartians.com>

# Dependencies
RUN apt-get update
RUN apt-get install -y curl git libpq-dev libsqlite3-dev libsasl2-dev postgresql-client vim zlib1g-dev gettext
RUN apt-get clean

# stellar-core ports
EXPOSE 11625 11626

# Settings
ENV STELLAR_CORE_VERSION "0.6.3-391-708237b0"
ENV CORE_DATABASE_URL "user=gzigzigzeo host=localhost dbname=core"
ENV NETWORK "testnet"
ENV STELLAR_DEB_URL "https://s3.amazonaws.com/stellar.org/releases/stellar-core/stellar-core-${STELLAR_CORE_VERSION}_amd64.deb"

# Installation
RUN wget -O stellar-core.deb $STELLAR_DEB_URL \
 && dpkg -i stellar-core.deb \
 && rm stellar-core.deb \
 && mkdir -p /opt/stellar-core/etc/default \
 && mkdir -p /var/stellar-core/${NETWORK}/history-cache

# Config files
COPY pubnet /opt/stellar-core/etc/default/pubnet
COPY testnet /opt/stellar-core/etc/default/testnet

# Helathcheck & Entrypoint
COPY start.sh healthcheck.sh /

ENTRYPOINT ["/start.sh"]
