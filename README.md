# easy-bun-https

Easy starter kit to jumpstart your bun project with https enabled.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/) can be be `docker compose` or `docker-compose`
- A domain name with a record pointing to your server's public IP address, can be a subdomain or a root domain.
- Ports 80 and 443 open on your server.

## Getting Started

1. Clone the repository
2. Create a `.env` file based on the `.env.example` file, add your domain name, email address and project name.
3. Run `docker-compose up -d`
4. Open your browser and open `https://your-domain-name.com`

## How it works

The `docker-compose.yml` file defines four services: `bun`, `nginx`, `certbot`, and `cron`.

- The `bun` service is a simple bun server that listens on port 3000.
- The `nginx` service first uses `nginx/nginx-templates/nginx.conf.template` that opens port 80 and allows `certobot` to verify the domain ownership. After the certificate is issued, the `nginx` service detects the certificate files and switches to `nginx/nginx-templates/nginx.conf.bkp` that opens port 443 and serves the bun server.
- The `certbot` service will issue a certificate using the provided domain name and email address.
- The `cron` service will try to renew the certificate every month.

## Troubleshooting

- If you encounter any issues, please check the logs of the services using `docker-compose logs -f <service-name>`.
- If the `docker-compose` command fails, try replacing it with `docker compose`.
- If you have troubles with the `certbot` service add `--staging` to the `certbot` command in the `docker-compose.yml` file to use the staging environment and avoid rate limits.