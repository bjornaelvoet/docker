FROM alpine:latest

RUN apk add --no-cache mono tzdata python3 --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing

# Need for certificates for mono security model to work
RUN apk add --no-cache --virtual=.build-dependencies ca-certificates &&\
    cert-sync /etc/ssl/certs/ca-certificates.crt &&\
    apk del .build-dependencies

COPY VERSION entrypoint.sh /root/
COPY src/* /tmp/

RUN mkdir -p /app/wg++/sites &&\ 
	tar xzf /tmp/WebGrabPlus_latest_install.tar.gz -C /app/wg++ --strip-components=1 &&\
	unzip -q /tmp/SiteIniPack_current.zip -d /app/wg++/sites &&\
	cp /tmp/main.py /app/wg++ &&\
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

VOLUME /config /data

ENV TZ=Europe/Brussels

ENTRYPOINT ["/root/entrypoint.sh"]
