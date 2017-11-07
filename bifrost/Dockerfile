FROM stellar/base:latest

MAINTAINER Viktor Sokolov <gzigzigzeo@evilmartians.com>

EXPOSE 8000

ENV GOPATH="/go"
ENV PATH "$PATH:/go/bin"

# Dependencies
RUN apt-get update
RUN apt-get install -y curl git vim mercurial subversion
RUN apt-get clean

# Directories
RUN mkdir /go
RUN mkdir -p /go/src/github.com/stellar
RUN mkdir /go/bin

# GO
RUN wget https://storage.googleapis.com/golang/go1.9.2.linux-amd64.tar.gz
RUN tar -xvf go1.9.2.linux-amd64.tar.gz
RUN rm go1.9.2.linux-amd64.tar.gz

# Glide
RUN curl https://glide.sh/get | sh

# Clone
RUN git clone --branch bifrost https://github.com/stellar/go.git /go/src/github.com/stellar/go

# Install deps & build
RUN cd /go/src/github.com/stellar/go && glide install
RUN cd /go/src/github.com/stellar/go/services/bifrost && go install

#ADD start /
#RUN ["chmod", "+x", "start"]

#ENTRYPOINT ["/init", "--", "/start" ]
