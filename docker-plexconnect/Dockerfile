FROM alpine:latest

RUN apk add --no-cache python py-pillow openssl tzdata 

# No need for DNS as we create our own DNS server
EXPOSE 80/tcp 443/tcp

ADD VERSION .

VOLUME /plexconnect

WORKDIR /plexconnect

ENV PLEXCONNECT_OPTIONS=
ENV TZ=Europe/Brussels

CMD ["sh", "-c", "python /plexconnect/PlexConnect.py $PLEXCONNECT_OPTIONS"]
