FROM debian:latest
MAINTAINER Pavel E. Dedkov <pavel.dedkov@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive
# env
ENV TIMEZONE Europe/Moscow

# install required software
RUN apt-get update \ 
&& apt-get upgrade -y \
&& apt-get install -y --no-install-recommends ca-certificates php5-cli php5-curl php5-redis php5-mysql php5-sqlite php5-mcrypt php5-gearman php5-mongo php-gettext php5-readline php5-tidy  php5-intl \
&& apt-get autoclean \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# configure php
RUN sed -i "/;date.timezone /c date.timezone = ${TIMEZONE}" /etc/php5/cli/php.ini \
&& sed -i "/^short_open_tag /c short_open_tag = On" /etc/php5/cli/php.ini

# configure app
WORKDIR /app

VOLUME ["/app"]

ENTRYPOINT ["/usr/bin/php"]
CMD ["-v"]
