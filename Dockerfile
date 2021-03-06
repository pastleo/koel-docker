
FROM php:7.1-fpm-alpine

RUN \
apk add -U mysql mysql-client ffmpeg nodejs python make gcc g++ \
libxml2-dev libmcrypt-dev && \
docker-php-ext-install exif iconv json pdo pdo_mysql mbstring tokenizer xml mcrypt zip && \
npm install -g yarn

RUN \
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
php composer-setup.php && \
php -r "unlink('composer-setup.php');" && \
mv composer.phar /usr/local/bin/composer

ADD app /usr/src/koel
WORKDIR /usr/src/koel
ENV BROADCAST_DRIVER=log

RUN \
/usr/local/bin/composer install

COPY scripts/* /usr/local/bin/
RUN chmod -R +x /usr/local/bin

ENV \
DB_CONNECTION=mysql \
DB_HOST=db \
DB_DATABASE=koel \
DB_USERNAME=koel \
DB_PASSWORD=koel-some-password \
KOEL_UID=1000 \
PHP_MEMORY_LIMIT=64M \
KOEL_MEDIA_PATH=/media \
KOEL_SYNC_PERIOD=7d \
ADMIN_EMAIL=admin@example.com \
ADMIN_NAME=admin \
ADMIN_PASSWORD=admin \
FFMPEG_PATH=/usr/bin/ffmpeg

CMD /usr/local/bin/entrypoint.sh

