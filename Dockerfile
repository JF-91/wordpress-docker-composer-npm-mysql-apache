FROM wordpress:php8.3-apache

# Instalar utilidades necesarias
RUN apt-get update && apt-get install -y \
    git \
    curl \
 && rm -rf /var/lib/apt/lists/*

# Instalar Node.js y npm (a través de nvm)
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install node



# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copiar tu archivo php.ini al contenedor
COPY php.ini /usr/local/etc/php/custom.ini

# Copiar tu código fuente al contenedor
COPY . /var/www/html

# Cambiar los permisos si es necesario
RUN chown -R www-data:www-data /var/www/html
