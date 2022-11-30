FROM php:8.1-fpm-alpine

ADD ./php/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN mkdir -p /var/www/html

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install extensions
RUN apk update \
    && apk upgrade \
    && apk --no-cache add \
    build-base \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libzip \
    libzip-dev \
    libxml2-dev \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl

RUN docker-php-ext-install pdo pdo_mysql exif pcntl bcmath
RUN docker-php-ext-install -j$(nproc) zip
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd
RUN docker-php-ext-enable gd

RUN docker-php-ext-enable exif bcmath

RUN apk --no-cache add pcre-dev ${PHPIZE_DEPS} \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del pcre-dev ${PHPIZE_DEPS}
# ADD ./src/ /var/www/html

# RUN chmod -R 777 /var/www/html/storage
# RUN chmod -R 777 /var/www/html/bootstrap/cache


RUN chown laravel:laravel /var/www/html
