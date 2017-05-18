FROM pdedkov/debian-php-base:latest
MAINTAINER Pavel E. Dedkov <pavel.dedkov@gmail.com>

# configure app
WORKDIR /app

VOLUME ["/app"]

ENTRYPOINT ["/usr/bin/php"]
CMD ["-v"]
