# ===============================================================

FROM alpine:latest as confd
ARG CONFD_VERSION=0.14.0

LABEL maintainer="Sergey Nebolsin <sergey@nebols.in>"

ENV CONFD_VERSION="${CONFD_VERSION}"
ENV CONFD_RELEASE="https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64"

RUN apk add --no-cache curl ca-certificates \
 && curl -L -o /usr/local/bin/confd "${CONFD_RELEASE}" \
 && chmod +x /usr/local/bin/confd

# ===============================================================

FROM instrumentisto/glide as glide
RUN /usr/local/bin/glide --version

# ===============================================================

FROM golang:1.9-alpine as bifrost

LABEL maintainer="Sergey Nebolsin <sergey@nebols.in>"

RUN apk add --update --no-cache ca-certificates git mercurial openssh

COPY --from=glide /usr/local/bin/glide /usr/local/bin/

WORKDIR /go/src/github.com/stellar/go

RUN git clone --branch bifrost --depth=3 https://github.com/stellar/go.git .
RUN glide install

RUN apk add --no-cache gcc musl-dev linux-headers
RUN go install github.com/stellar/go/services/bifrost

# ===============================================================

FROM alpine:latest

LABEL maintainer="Sergey Nebolsin <sergey@nebols.in>"

RUN apk add --no-cache bash

COPY --from=confd /usr/local/bin/confd /usr/local/bin/confd
COPY templates /etc/confd/templates/
COPY conf.d /etc/confd/conf.d/

COPY --from=bifrost /go/bin/bifrost /usr/local/bin/

COPY docker_entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bifrost", "server", "--debug", "--config", "/etc/bifrost.cfg"]
EXPOSE 8000

