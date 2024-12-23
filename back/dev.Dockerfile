# # dev.Dockerfile
# FROM php:8.3.12-fpm

# # Installer les dépendances nécessaires
# RUN apt-get update && apt-get install -y \
#     libzip-dev \
#     unzip \
#     nginx \
#     libmariadb-dev \
#     && docker-php-ext-install zip pdo pdo_mysql

# # Définir le répertoire de travail
# WORKDIR /var/www/html

# # Copier les fichiers du projet
# COPY . .

# # Installer Composer
# COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# # Copier la configuration Nginx
# COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# # Installer les dépendances PHP via Composer
# RUN composer install

# EXPOSE 9000
# CMD ["sh", "-c", "php-fpm & nginx -g 'daemon off;'"]


# dev.Dockerfile
FROM php:8.3.12-fpm

# Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    libmariadb-dev \
    && docker-php-ext-install zip pdo pdo_mysql


# Créer un utilisateur non-root
RUN addgroup --gid 1001 appgroup && \
adduser --uid 1001 --ingroup appgroup --shell /bin/sh --disabled-password appuser

# Définir le répertoire de travail
WORKDIR /var/www/html

# Copier les fichiers du projet
COPY . .

COPY generate-settings.sh /usr/local/bin/generate-settings.sh
RUN chmod +x /usr/local/bin/generate-settings.sh

# Donner les permissions au nouvel utilisateur
RUN chown -R appuser:appgroup /var/www/html

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN composer install

# Changer l'utilisateur courant pour `appuser`
USER appuser

# Exposer uniquement PHP-FPM
EXPOSE 9000

# Lancer PHP-FPM directement (sans Nginx)
CMD ["php", "-S", "0.0.0.0:9090", "-t", "public"]
