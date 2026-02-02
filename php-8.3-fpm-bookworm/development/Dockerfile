FROM php:8.3-fpm-bookworm

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
    apache2-utils \
    cron \
    curl \
    ffmpeg \
    freetype* \
    gettext-base \
    ghostscript \
    git \
    imagemagick \
    iputils-ping \
    libc-client-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libkrb5-dev \
    libmagickcore-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    libmemcached-dev \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
    memcached \
    nano \
    nginx \
    poppler-utils \
    sendmail \
    supervisor \
    systemd \
    unzip \
    wait-for-it \
    wget \
    zip \
    zlib1g-dev; \
	rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg; \
    docker-php-ext-install -j$(nproc) \
    gd \
    mysqli \
    opcache \
    zip

RUN pecl install apcu; \
    docker-php-ext-enable apcu

RUN pecl install --onlyreqdeps --force redis; \
    rm -rf /tmp/pear; \
    docker-php-ext-enable redis

RUN pecl install xdebug-3.5.0; \
    docker-php-ext-enable xdebug

COPY docker-entrypoint.sh /usr/local/bin/
COPY config/conf/nginx.conf /etc/nginx/conf.d/nginx.conf
COPY config/conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY config/ini/php.ini /usr/local/etc/php/conf.d/php.ini
COPY config/ini/opcache-recommended.ini /usr/local/etc/php/conf.d/opcache-recommended.ini
COPY config/ini/error-logging.ini /usr/local/etc/php/conf.d/error-logging.ini
COPY config/ini/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
COPY config/scr /tmp/scr

RUN sed -i 's/\r$//' /usr/local/bin/docker-entrypoint.sh; \
    chmod +x /usr/local/bin/docker-entrypoint.sh; \
    sed -i 's/\r$//' /tmp/scr/*.sh; \
    chmod +x /tmp/scr/*

CMD ["docker-entrypoint.sh"]
