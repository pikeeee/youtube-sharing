#!/bin/bash
set -e

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

# Check if the database exists
bundle exec rake db:exists || bundle exec rake db:create

# then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
