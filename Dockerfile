FROM php:7.2-apache-stretch

COPY docker/composer-installer.sh /usr/local/bin/composer-installer
RUN chmod +x /usr/local/bin/composer-installer

RUN apt-get -yqq update && apt-get -yqq install --no-install-recommends git zip unzip libpq-dev \
    && composer-installer \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer \
    && composer global require hirak/prestissimo

RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && docker-php-ext-install pdo pdo_pgsql pgsql
