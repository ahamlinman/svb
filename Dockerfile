FROM docker

RUN apk add --no-cache \
  bash \
  python3

RUN pip3 install --no-cache-dir awscli

COPY svb /usr/local/bin/svb
COPY svb-cmd /usr/local/bin/svb-cmd/

ENTRYPOINT ["/usr/local/bin/svb"]
