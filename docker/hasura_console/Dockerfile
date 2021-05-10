FROM ubuntu:latest

RUN apt-get update -y && \
    apt-get install -y curl socat

RUN curl -L https://github.com/hasura/graphql-engine/raw/stable/cli/get.sh | bash

RUN hasura update-cli --version v2.0.0-alpha.10

WORKDIR /opt/hasura

COPY ./run.sh /usr/bin/run

RUN chmod +x /usr/bin/run

CMD "/usr/bin/run"