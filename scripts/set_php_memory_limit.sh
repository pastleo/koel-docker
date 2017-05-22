#!/bin/sh

if [ "$PHP_MEMORY_LIMIT" ] && ! [ $(grep memory_limit /usr/local/etc/php/php.ini &>/dev/null) ]; then
  echo ">> setting php memory limit..."
  echo "memory_limit = $PHP_MEMORY_LIMIT ;" >> /usr/local/etc/php/php.ini
fi

