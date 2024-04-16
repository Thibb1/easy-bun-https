#!/bin/sh

set -e

ME=$(basename "$0")

cd /app
echo "$ME: Run certbot renew"
docker-compose run --no-deps certbot renew
echo "$ME: Waiting for nginx to finish restarting"
while true; do
    if docker compose exec nginx nginx -t; then
        break
    fi
    sleep 10
done
echo "$ME: Run nginx reload"
docker compose exec nginx nginx -s reload
echo "$ME: Done"
