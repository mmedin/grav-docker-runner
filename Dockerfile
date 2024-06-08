FROM php:8-apache

RUN a2enmod rewrite expires

# install the PHP extensions we need
RUN apt-get update \
    && apt-get install -y git rsync zip \
    && apt-get install -y libzip-dev libpng-dev libjpeg-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install gd opcache zip  \
    && docker-php-ext-configure gd --with-jpeg=/usr

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
    echo 'opcache.memory_consumption=128'; \
    echo 'opcache.interned_strings_buffer=8'; \
    echo 'opcache.max_accelerated_files=4000'; \
    echo 'opcache.revalidate_freq=60'; \
    echo 'opcache.fast_shutdown=1'; \
    echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini
