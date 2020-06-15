FROM alpine:latest

RUN apk add --no-cache dovecot

EXPOSE 143/tcp 993/tcp

WORKDIR /root

VOLUME ["/conf"]
VOLUME ["/maildata"]
VOLUME ["/import"]

ENV DOVECOT_CONF_FILE dovecot.conf 
ENV DOVECOT_OPTIONS ""
ENV DOVECOT_USERS_PASSWORDS dovecot.users
ENV DOVECOT_USER_QUOTA=100MB
ENV DOVECOT_MAIL_USERID=1000
ENV DOVECOT_MAIL_GROUPID=1000

COPY VERSION entrypoint.sh /root/

ENTRYPOINT ["/root/entrypoint.sh"]
# To be able to pass extra arguments to the entrypoint
CMD []
