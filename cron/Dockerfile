FROM alpine:latest
RUN apk add --no-cache docker-cli docker-cli-compose
COPY cron-task.sh /cron-task.sh
# RUN echo "* * * * * /cron-task.sh" | crontab -
RUN echo "44 4 * * 4 /cron-task.sh" | crontab -
ENTRYPOINT ["crond", "-f", "-L", "/dev/stdout"]