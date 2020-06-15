FROM alpine:latest

# Corutils needed for du, tzdata needed for setting local hour
RUN apk --no-cache add rsnapshot coreutils tzdata

ADD VERSION entrypoint.sh /app/

WORKDIR /app

VOLUME ["/backup"]
VOLUME ["/data"]
VOLUME ["/conf"]

ENV RSNAPSHOT_CONF_FILE rsnapshot.conf
ENV RSNAPSHOT_OPTIONS=-x
ENV RSNAPSHOT_BACKUP_NAME=localhost
ENV RSNAPSHOT_BACKUP_OPTIONS=
ENV TZ=Europe/Brussels

ENTRYPOINT ["/app/entrypoint.sh"]
CMD []
