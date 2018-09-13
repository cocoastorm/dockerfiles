FROM alpine:3.8

COPY ./docker-entrypoint.sh /

RUN apk update \
  && apk upgrade \
  && apk add --no-cache \
    mysql-client \
    openssh \
    rsync \
  && rm -rf /var/cache/apk

EXPOSE 22

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D"]
