#!/bin/sh

set -e

/usr/local/bin/wait_db.sh
/usr/local/bin/set_php_memory_limit.sh
/usr/local/bin/create_koel_user.sh

echo ">> php artisan koel:init"
su -c 'php artisan koel:init' koel

echo ">> starting php-fpm ..."
php-fpm
