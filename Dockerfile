#
# Dockerfile for kcptun-server
#

FROM alpine:3.4
MAINTAINER siqi <masiqi@gmail.com>

WORKDIR /ssr/

RUN set -ex \
  && apk update \
  && apk add --no-cache --virtual .build-deps git \
  && git clone -b manyuser https://github.com/breakwa11/shadowsocks.git \
  && apk del .build-deps \
  && apk add python


ENV LISTEN_PORT 443
ENV KEY password 
ENV METHOD aes-256-cfb
ENV OBFS http_simple
ENV PROTOCOL auth_sha1_v4

EXPOSE $LISTEN_PORT

CMD python /ssr/shadowsocks/shadowsocks/server.py -p $LISTEN_PORT \
                                              -k $KEY \
                                              -m $METHOD \
                                              -O $PROTOCOL \
                                              -o #OBFS
