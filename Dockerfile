
FROM php:7.1-fpm-alpine

RUN \
apk update && \
apk add mysql mysql-client ffmpeg nodejs \
libxml2-dev libmcrypt-dev && \
docker-php-ext-install exif iconv json pdo pdo_mysql mbstring tokenizer xml mcrypt zip && \
npm install -g yarn

RUN \
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
php composer-setup.php && \
php -r "unlink('composer-setup.php');" && \
mv composer.phar /usr/local/bin/composer

ADD app /usr/src/koel
WORKDIR /usr/src/koel
ENV BROADCAST_DRIVER=log

RUN \
composer install

RUN \
apk add --no-cache python make gcc g++ && \
yarn && \
apk del python make gcc g++

VOLUME /usr/src/koel/public

ADD entrypoint.sh /usr/local/bin/entrypoint
RUN chmod -R +x /usr/local/bin

CMD /usr/local/bin/entrypoint

