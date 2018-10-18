FROM ahamlinman/foundation

COPY svb /usr/local/bin/svb
COPY lib /usr/local/lib/svb/

ENTRYPOINT ["/usr/local/bin/svb"]
