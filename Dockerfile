ARG UBUNTU_VERSION=noble
ARG PHP_VERSION=8.4

FROM ubuntu:$UBUNTU_VERSION

ENV DEBIAN_FRONTEND=noninteractive

RUN apt -qqq --allow-releaseinfo-change update

RUN apt -qqq install software-properties-common

RUN add-apt-repository --yes ppa:ondrej/php

RUN apt -qqq install ca-certificates && /usr/sbin/update-ca-certificates

RUN apt -qqq install php${PHP_VERSION}

RUN <<END bash

set -euo pipefail

PKGS=""

for MOD in bcmath bz2 cli curl dev gmp intl mbstring mysql sqlite3 xml yaml ; do
    PKGS="$(printf "%s php%.1f-%s" "\${PKGS}" "${PHP_VERSION}" "\${MOD}")"
done

apt -qqq install \${PKGS}
END

#
# the "memcache" extension appears to have been deprecated/removed for
# PHP v8.5, so install "memcached" instead when "memcache" isn't available.
#
RUN apt -qqq install php$PHP_VERSION-memcache || apt -qqq install php$PHP_VERSION-memcached

RUN apt -qqq install php-pear composer libcurl4-openssl-dev

RUN pecl channel-update pecl.php.net

RUN (yes yes | head -5 ; echo no) | pecl install openswoole

RUN echo extension=openswoole.so > /etc/php/${PHP_VERSION}/cli/conf.d/99-openswoole.ini
