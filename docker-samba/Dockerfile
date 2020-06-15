FROM alpine:latest

RUN apk --no-cache add samba

EXPOSE 445/tcp

COPY VERSION entrypoint.sh /root/

WORKDIR /conf

VOLUME ["/conf"]

ENV SAMBA_CONF_FILE samba.conf
ENV SAMBA_USERS=samba.users
ENV SAMBA_OPTIONS=

# add a non-root user and group called "rio" with no password, no home dir, no shell, and gid/uid set to 1000
#RUN addgroup -g 1000 rio && adduser -D -H -G rio -s /bin/false -u 1000 rio

ENTRYPOINT ["/root/entrypoint.sh"]
