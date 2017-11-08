FROM stellar/base:latest

MAINTAINER Viktor Sokolov <gzigzigzeo@evilmartians.com>

# Dependencies
RUN apt-get update
RUN apt-get install -y curl git libpq-dev libsqlite3-dev libsasl2-dev postgresql-client vim zlib1g-dev rpl
RUN apt-get clean

# stellar-core ports
EXPOSE 8000

# Settings
ENV HORIZON_VERSION 0.11.0
ENV HORIZON_DATABASE_URL "postgres://gzigzigzeo@localhost/horizon"
ENV STELLAR_CORE_DATABASE_URL "postgres://gzigzigzeo@localhost/core"
ENV STELLAR_CORE_URL="http://localhost:11626"
ENV STELLAR_TAR_URL "https://github.com/stellar/horizon/releases/download/v${HORIZON_VERSION}/horizon-v${HORIZON_VERSION}-linux-amd64.tar.gz"
ENV LOG_LEVEL="info"
ENV INGEST="true"
ENV PER_HOUR_RATE_LIMIT="72000"

# Installation
RUN wget -O horizon.tar.gz $STELLAR_TAR_URL
RUN tar -zxvf horizon.tar.gz
RUN mv /horizon-v${HORIZON_VERSION}-linux-amd64/horizon /usr/local/bin
RUN chmod +x /usr/local/bin/horizon
RUN rm -rf horizon.tar.gz /horizon-v${HORIZON_VERSION}-linux-amd64

# Healthcheck
ADD healthcheck.sh /
RUN chmod +x healthcheck.sh

# Entrypoint
ADD start.sh /
RUN chmod +x start.sh

ENTRYPOINT /start.sh
