FROM alpine:latest

LABEL description="mysql-client" \
      maintainer="Khoa Nguyen <khoa.tan.nguyen.96@gmail.com>"

RUN apk add --no-cache bash curl mysql-client

# Install wait-for-it
RUN curl --location --output /usr/local/bin/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh \
  && ln -s usr/local/bin/wait-for-it.sh \
  && chmod +x /usr/local/bin/wait-for-it.sh

ENTRYPOINT ["mysql"]