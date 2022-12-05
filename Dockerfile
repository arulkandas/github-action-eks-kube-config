FROM python:3.7.15-slim-buster

LABEL maintainer="Arulkumar Kandasamy"

RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install jq


RUN pip install awscli

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]