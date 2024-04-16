#!/bin/sh

set -e

ME=$(basename "$0")

entrypoint_log() {
    if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
        echo "$@"
    fi
}

copy_templates() {
    entrypoint_log "$ME: Creating /etc/nginx/templates directory"
    mkdir -p /etc/nginx/templates
    entrypoint_log "$ME: Copying templates from volume to /etc/nginx/templates"
    cp -r /nginx-templates/* /etc/nginx/templates
}

copy_templates

exit 0