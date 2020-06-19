FROM alpine:latest

RUN apk --no-cache add tzdata python2 git py-pip py-setuptools

# Create a group and user
RUN addgroup -S appgroup --gid 1001 && adduser -S appuser --uid 1000 -G appgroup

# Get the tvgrabpy python sources
WORKDIR /app
RUN git clone https://github.com/tvgrabbers/tvgrabpyAPI.git

# Install dependencies
RUN pip install pytz requests
# DataTreeGrab depends on pytz, thus install after pytz install
RUN pip install DataTreeGrab

ENV TVGRABPY_OPTIONS=
ENV TZ=Europe/Brussels

COPY VERSION entrypoint.sh /app/

VOLUME /conf

# Tell docker that all future commands should run as the appuser user
USER appuser

ENTRYPOINT ["/app/entrypoint.sh"]
