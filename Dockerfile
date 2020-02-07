FROM alpine:3.10

COPY entrypoint.sh /entrypoint.sh
COPY github-sync.sh /github-sync.sh

RUN apk add --no-cache git openssh-client && \
  echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

ENTRYPOINT ["/entrypoint.sh"]