FROM php:8.5-fpm-trixie

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
    acl \
    apache2-utils \
    build-essential \
    chrpath \
    cron \
    curl \
    dos2unix \
    g++ \
    gettext-base \
    ghostscript \
    ghostscript-doc \
    ghostscript-x \
    gifsicle \
    git \
    imagemagick \
    iputils-ping \
    jpegoptim \
    libavif-dev \
    libcurl4-openssl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libheif-dev \
    libheif-plugins-all \
    libicu-dev \
    libjpeg62-turbo-dev \
    libkrb5-dev \
    libmagickcore-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    libmemcached-dev \
    libpng-dev \
    libpq-dev \
    libsodium-dev \
    libssh2-1-dev \
    libssl-dev \
    libwebp-dev \
    libxft-dev \
    libxml2-dev \
    libxpm-dev \
    libxslt-dev \
    libzip-dev \
    memcached \
    nano \
    neowofetch \
    nginx \
    nodejs \
    npm \
    openssl \
    optipng \
    poppler-utils \
    sendmail \
    supervisor \
    systemd \
    texlive-extra-utils \
    unzip \
    wait-for-it \
    webp \
    wget \
    zip \
    zlib1g-dev; \
	rm -rf /var/lib/apt/lists/*

RUN npm install -g svgo sharp svg2png svg-to-pdf imagemin-svgo svg2pdf
RUN ln -s /usr/local/bin/svgo /usr/bin/svgo

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN curl -sL https://raw.githubusercontent.com/axllent/mailpit/develop/install.sh | sh

RUN docker-php-ext-configure intl; \
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl; \
    docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp --with-xpm; \
    docker-php-ext-install -j$(nproc) \
    bcmath \
    exif \
    gd \
    intl \
    mysqli \
    pcntl \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    sockets \
    xml \
    xsl \
    zip

RUN pecl install imagick; \
    docker-php-ext-enable imagick

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
