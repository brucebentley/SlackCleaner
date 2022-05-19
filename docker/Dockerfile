FROM python:3.11.0b1-alpine

LABEL maintainer="Bruce Bentley <brucebentley@me.com>"

VOLUME "/backup"
WORKDIR /backup

RUN pip --no-cache-dir install SlackCleaner

CMD ["python", "-"]
