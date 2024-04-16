FROM nginx:mainline-alpine
# https://ssl-config.mozilla.org/
RUN curl https://ssl-config.mozilla.org/ffdhe2048.txt > /etc/ssl/certs/dhparam.pem
# all scripts in /docker-entrypoint.d will be executed before nginx starts
COPY ./01-copy-template-from-volume.sh /docker-entrypoint.d
COPY ./02-check-ssl-cert.sh /docker-entrypoint.d