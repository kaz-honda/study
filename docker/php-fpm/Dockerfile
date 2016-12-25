FROM php:5.6.26-fpm-alpine

#
# apk packege
#
RUN apk update \
    && apk add --no-cache --virtual .php-deps \
        autoconf \
        g++ \
        gcc \
        make \
        curl \
        libmemcached-dev \
        cyrus-sasl-dev \
        zlib-dev \
        php5-memcache

# 作業ディレクトリ
RUN mkdir /usr/local/src
#
# xdebugのインストール
#
#RUN cd /usr/local/src \
#    && curl -O https://xdebug.org/files/xdebug-2.4.1.tgz \
#    && tar zxf xdebug-2.4.1.tgz \
#    && cd /usr/local/src/xdebug-2.4.1 \
#    && phpize \
#    && ./configure --with-php-config=/usr/local/bin/php-config \
#    && make \
#    && make install

#
# install php extension
#
RUN docker-php-ext-install \
        mysql \
        mysqli \
        pdo \
        pdo_mysql

RUN pecl install memcache \
    && docker-php-ext-enable memcache

#
# 設定ファイルのコピー
#
COPY config/php.ini /usr/local/etc/php/php.ini

# ゴミ掃除
RUN rm -rf /usr/local/src
