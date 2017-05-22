#!/bin/sh

echo ">> using user koel with uid $KOEL_UID..."
adduser -u $KOEL_UID -D koel &>/dev/null || true
chown -R koel /usr/src/koel
grep koel /usr/local/etc/php-fpm.d/zz-docker.conf || \
echo 'user = koel' >> /usr/local/etc/php-fpm.d/zz-docker.conf

