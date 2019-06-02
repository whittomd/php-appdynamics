FROM php:7.1-fpm
RUN apt-get update && apt-get install -y \
        zlib1g-dev libicu-dev g++ \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libxml2-dev \
        libmemcached-dev \
    && docker-php-ext-install intl \
    && docker-php-ext-install -j$(nproc) iconv mcrypt soap \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && pecl install memcached \
    && docker-php-ext-enable memcached \
    && pecl install redis && docker-php-ext-enable redis \
    && pecl install apcu && docker-php-ext-enable apcu \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && docker-php-ext-install sysvsem shmop
RUN apt-get update && apt-get install -y \
    libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
	&& docker-php-ext-enable imagick
ADD appdynamics-php-agent-linux_x64/appdynamics-php-agent-linux_x64.tar.bz2 /opt/
ADD installAndStart.sh /usr/local/bin/installAndStart.sh
RUN chmod u+x /usr/local/bin/installAndStart.sh
#RUN apt-get update && apt-get install procps
ENTRYPOINT ["/usr/local/bin/installAndStart.sh"]
