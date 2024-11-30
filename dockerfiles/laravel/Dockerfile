# Use official PHP image with Apache
FROM php:8.1-fpm

# Install dependencies
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zip git && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd pdo pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www

# Copy Laravel project
COPY ./src /var/www

# Install dependencies using Composer
RUN composer install

# Expose the application port
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
