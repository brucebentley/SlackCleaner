FROM python:3.12.0a4-alpine

LABEL maintainer="Bruce Bentley <brucebentley@me.com>"

VOLUME "/backup"
WORKDIR /backup
CMD ["python", "-i", "-c", "\"from SlackCleaner import *\""]

RUN apk add --update bash && rm -rf /var/cache/apk/*
# for better layers
ADD ./requirements* /data/
RUN pip --no-cache-dir install -r /data/requirements.txt

ADD . /data
RUN pip --no-cache-dir install /data
