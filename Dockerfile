FROM php:8.2-fpm

# Install dependensi sistem
RUN apt-get update && apt-get install -y \
    git unzip curl libpng-dev libonig-dev libxml2-dev zip \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy composer files terlebih dahulu
COPY composer.json composer.lock ./

RUN composer install --no-dev --no-interaction --optimize-autoloader

# Baru copy sisa file
COPY . .

# Jalankan Composer install jika belum ada vendor
RUN if [ ! -d "vendor" ]; then composer install; fi

CMD ["php-fpm"]
