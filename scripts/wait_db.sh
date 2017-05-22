#!/bin/sh

until mysqladmin --host="$DB_HOST" --password="$DB_PASSWORD" --user="$DB_USERNAME" ping; do
  echo "mysql is unavailable - sleeping"
  sleep 5
done

echo "mysql is up - executing command"
