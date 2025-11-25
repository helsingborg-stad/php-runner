FROM php:8.3-cli

# 1. System dependencies
RUN apt-get update && apt-get install -y \
	git \
	curl \
	unzip \
	libzip-dev \
	libonig-dev \
	libxml2-dev \
	libmagickwand-dev \
	ca-certificates \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# 2. PHP extensions
RUN docker-php-ext-install zip mbstring xml

# 3. Imagick
RUN pecl install imagick \
	&& docker-php-ext-enable imagick

# 4. Composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php \
	&& php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
	&& rm composer-setup.php

# 5. Node
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
	&& apt-get install -y nodejs \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /app
