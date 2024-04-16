#!/bin/sh

set -e

ME=$(basename "$0")

entrypoint_log() {
    if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
        echo "$@"
    fi
}

move_if_exists() {
    if [ -f "$1" ]; then
        entrypoint_log "$ME: Moving $1 to $2"
        mv "$1" "$2"
    fi
}

check_ssl_cert() {
    entrypoint_log "$ME: Starting background process to check for SSL certificate"
    # wait for certbot to finish issuing certificates
    while [ ! -f /etc/letsencrypt/live/$DOMAIN/fullchain.pem ]; do
        sleep 1
    done
    entrypoint_log "$ME: SSL certificate found"
    # change the nginx configuration template
    move_if_exists /etc/nginx/templates/nginx.conf.bkp /etc/nginx/templates/nginx.conf.template
    # reload template configurations
    sh /docker-entrypoint.d/20-envsubst-on-templates.sh
    entrypoint_log "$ME: Reloading NGINX"
    nginx -s reload
}

# run check_ssl_cert in the background
check_ssl_cert &

exit 0