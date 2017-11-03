FROM stellar/base:latest

MAINTAINER Viktor Sokolov <gzigzigzeo@evilmartians.com>

EXPOSE 8000

ENV PGUSER="stellar"
ENV PGPASS=""
ENV PGHOST="localhost"
ENV GOPATH="/go"
ENV PATH "$PATH:/go/bin"

RUN ["mkdir", "/go"]
RUN ["mkdir", "-p", "/go/src/github.com/stellar"]
RUN ["mkdir", "/go/bin"]

ADD dependencies /
RUN ["chmod", "+x", "dependencies"]
RUN /dependencies

ADD install /
RUN ["chmod", "+x", "install"]
RUN /install

ADD start /
RUN ["chmod", "+x", "start"]

ENTRYPOINT ["/init", "--", "/start" ]
