# Get latest Composer
FROM composer:latest AS composer

RUN docker-php-ext-install pdo pdo_mysql exif pcntl bcmath
RUN docker-php-ext-install -j$(nproc) zip

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd
RUN docker-php-ext-enable gd