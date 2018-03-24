FROM php:7.2-apache
MAINTAINER daniel@nicacio.eng.br

RUN apt-get update \
    && apt-get install -y \
        libjpeg-dev  \
        curl \
        sed \
        zlib1g-dev \
		git \
		unzip \
		vim \
	&& docker-php-ext-install \
        pdo \
		pdo_mysql \
		zip \
        mysqli 

RUN a2enmod rewrite
		
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"
RUN composer global require "laravel/installer"
RUN echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> ~/.bashrc
RUN ex -sc '%s/None/All/g|x' /etc/apache2/apache2.conf

EXPOSE 80 443

WORKDIR /var/www/html/