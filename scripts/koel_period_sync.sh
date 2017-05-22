#!/bin/sh

/usr/local/bin/wait_db.sh
/usr/local/bin/set_php_memory_limit.sh
/usr/local/bin/create_koel_user.sh

until \
mysql --host="$DB_HOST" --password="$DB_PASSWORD" --user="$DB_USERNAME" --database="$DB_DATABASE" \
--execute="SHOW TABLES;" | \
grep settings >> /dev/null; do
  echo "koel not ready - sleeping"
  sleep 5
done

while true; do
  echo ">> setting koel media_path ..."
  mysql --host="$DB_HOST" --password="$DB_PASSWORD" --user="$DB_USERNAME" --database="$DB_DATABASE" \
  --execute="UPDATE settings SET value='s:$(expr length "$KOEL_MEDIA_PATH"):\"$KOEL_MEDIA_PATH\";';"
  
  echo ">> php artisan koel:sync ..."
  su -c 'php artisan koel:sync --no-interaction' koel

  echo ">> sleep for $KOEL_SYNC_PERIOD ..."
  sleep $KOEL_SYNC_PERIOD
done

