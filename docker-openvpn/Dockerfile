FROM alpine:latest

ADD VERSION entrypoint.sh /app/

RUN apk --no-cache add openvpn iptables tzdata

WORKDIR /app

EXPOSE 1195/tcp
EXPOSE 1194/udp

VOLUME ["/conf"]
VOLUME ["/pki"]

ENV OPENVPN_CONF_FILE=server.conf
ENV OPENVPN_OPTIONS=
ENV TZ=Europe/Brussels

ENTRYPOINT ["/app/entrypoint.sh"]
