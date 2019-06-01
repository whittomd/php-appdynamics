FROM php:7.1-fpm
RUN docker-php-ext-install sysvsem shmop
RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev g++ \
    && docker-php-ext-install intl
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
RUN apt-get update -y \
    && apt-get install -y \
    libxml2-dev \
    && apt-get clean -y \
    && docker-php-ext-install soap
RUN apt-get update && apt-get install -y \
    libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
	&& docker-php-ext-enable imagick
RUN apt-get update && apt-get install -y libmemcached-dev \
    && pecl install memcached \
    && docker-php-ext-enable memcached
RUN pecl install redis && docker-php-ext-enable redis
RUN pecl install apcu && docker-php-ext-enable apcu
RUN docker-php-ext-install mysqli
ADD appdynamics-php-agent-linux_x64/appdynamics-php-agent-linux_x64.tar.bz2 /opt/
ADD installAndStart.sh /usr/local/bin/installAndStart.sh
RUN php --ini
RUN chmod u+x /usr/local/bin/installAndStart.sh
RUN docker-php-ext-install pdo
RUN php -m
#RUN apt-get update && apt-get install procps
ENTRYPOINT ["/usr/local/bin/installAndStart.sh"]
