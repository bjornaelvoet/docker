FROM alpine:latest

RUN apk --no-cache add dnsmasq

EXPOSE 53/tcp 53/udp

ADD VERSION .

WORKDIR /conf

VOLUME ["/conf"]

ENV DNSMASQ_CONF_FILE dnsmasq.conf 
ENV DNSMASQ_HOST_FILE dnsmasq.static
ENV DNSMASQ_OPTIONS="" 

CMD ["sh", "-c", "dnsmasq --keep-in-foreground --conf-file=/conf/$DNSMASQ_CONF_FILE --addn-hosts=/conf/$DNSMASQ_HOST_FILE $DNSMASQ_OPTIONS"]
