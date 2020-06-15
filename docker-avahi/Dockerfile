FROM alpine:latest

RUN apk add --no-cache avahi

ADD VERSION .

WORKDIR /conf

VOLUME ["/conf"]
VOLUME ["/etc/avahi/services"]

EXPOSE 5353/udp

ENV AVAHI_CONF_FILE avahi.conf 
ENV AVAHI_OPTIONS=

ENTRYPOINT ["sh", "-c", "avahi-daemon --file /conf/$AVAHI_CONF_FILE $AVAHI_OPTIONS"]
CMD []
