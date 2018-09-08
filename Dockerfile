FROM docker.alexhamlin.co/server-tools/foundation

COPY svb /usr/local/bin/svb
COPY lib /usr/local/lib/svb/

ENTRYPOINT ["/usr/local/bin/svb"]
