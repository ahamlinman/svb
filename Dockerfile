FROM docker

RUN apk add --no-cache \
  bash \
  python3

RUN pip3 install --no-cache-dir awscli

COPY svb /usr/local/bin/svb
COPY lib /usr/local/lib/svb/

ENTRYPOINT ["/usr/local/bin/svb"]
