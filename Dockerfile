FROM alpine:latest
MAINTAINER Vadim Pavlov<ioc2rpz@gmail.com>
WORKDIR /opt/doh

RUN mkdir -p /opt/doh/etc /opt/doh/ssl /opt/doh/bin /opt/doh/log \
	  apk update && apk upgrade && apk add bash certbot go git make musl-dev && \
	  git clone https://github.com/m13253/dns-over-https.git && \
	  cd dns-over-https && make && cp doh-server/doh-server /opt/doh/bin/

ADD run_doh.sh /opt/doh/bin/


EXPOSE 80/tcp 443/tcp
CMD ["/bin/bash", "/opt/doh/bin/run_doh.sh"]

