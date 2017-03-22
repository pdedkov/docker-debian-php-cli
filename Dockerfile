FROM debian:latest
MAINTAINER Pavel E. Dedkov <pavel.dedkov@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

# env
ENV TIMEZONE Europe/Moscow

RUN apt-get update && apt-get install -y wget && echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list && wget https://www.dotdeb.org/dotdeb.gpg && apt-key add dotdeb.gpg && rm -f dotdeb.gpg

# install required software
RUN apt-get update \ 
&& apt-get upgrade -y \
&& apt-get install -y --no-install-recommends ca-certificates php7.0-cli php7.0-curl php7.0-redis php7.0-mysql php7.0-sqlite3 php7.0-mongodb php7.0-readline php7.0-tidy  php7.0-intl php7.0-mbstring php7.0-bcmath php7.0-xml  php7.0-imagick \
&& apt-get autoclean \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# configure php
RUN sed -i "/;date.timezone /c date.timezone = ${TIMEZONE}" /etc/php/7.0/cli/php.ini \
&& sed -i "/^short_open_tag /c short_open_tag = On" /etc/php/7.0/cli/php.ini

# configure app
WORKDIR /app

VOLUME ["/app"]

ENTRYPOINT ["/usr/bin/php"]
CMD ["-v"]
