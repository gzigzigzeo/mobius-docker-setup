# ===============================================================

FROM instrumentisto/glide as glide
RUN /usr/local/bin/glide --version

# ===============================================================

FROM golang:1.9-alpine as bifrost

LABEL maintainer="Sergey Nebolsin <sergey@nebols.in>"

RUN apk add --update --no-cache ca-certificates gcc git linux-headers mercurial musl-dev openssh

COPY --from=glide /usr/local/bin/glide /usr/local/bin/

WORKDIR /go/src/github.com/stellar/go

RUN git clone --branch bifrost --depth=3 https://github.com/stellar/go.git .
RUN glide --debug install
RUN go install github.com/stellar/go/services/bifrost

# ===============================================================

FROM itsthenetwork/alpine-confd:latest

LABEL maintainer="Sergey Nebolsin <sergey@nebols.in>"

RUN apk add --no-cache bash

COPY templates /etc/confd/templates/
COPY conf.d /etc/confd/conf.d/

COPY --from=bifrost /go/bin/bifrost /usr/local/bin/

COPY docker_entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bifrost", "server", "--debug", "--config", "/etc/bifrost.cfg"]
EXPOSE 8000

