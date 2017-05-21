#!/bin/sh

set -e

until mysqladmin --host="$DB_HOST" --password="$DB_PASSWORD" --user="$DB_USERNAME" ping; do
  echo "mysql is unavailable - sleeping"
  sleep 1
done

echo "mysql is up - executing command"

echo ">> php artisan koel:init"
php artisan koel:init

echo ">> using user koel with uid $UID..."
adduser -u $UID -D koel &>/dev/null || true
chown -R koel /usr/src/koel
grep koel /usr/local/etc/php-fpm.d/zz-docker.conf || \
echo 'user = koel' >> /usr/local/etc/php-fpm.d/zz-docker.conf

echo ">> starting php-fpm ..."
php-fpm

