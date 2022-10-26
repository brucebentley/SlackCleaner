FROM python:3.12.0a1-alpine

LABEL maintainer="Bruce Bentley <brucebentley@me.com>"

VOLUME "/backup"
WORKDIR /backup

RUN pip --no-cache-dir install SlackCleaner

CMD ["python", "-"]
