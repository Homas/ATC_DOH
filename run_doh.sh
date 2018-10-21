#!/bin/bash
#ATC DOH start script

SYSUSER=`whoami | awk '{print $1}'`
DOH_ROOT="/opt/doh"

if [ ! -f $DOH_ROOT/ssl/doh.crt ]; then
	certbot -n certonly --standalone -d $HOST --agree-tos --email $EMAIL
	cp /etc/letsencrypt/live/$HOST/fullchain.pem $DOH_ROOT/ssl/doh.crt
	cp /etc/letsencrypt/live/$HOST/privkey.pem $DOH_ROOT/ssl/doh.key
fi

if [ ! -f $DOH_ROOT/etc/doh-server.conf ]; then
    cat >> $DOH_ROOT/etc/doh-server.conf  << EOF
listen = ["172.17.0.2:443",]
cert = "$DOH_ROOT/ssl/doh.crt"
key = "$DOH_ROOT/ssl/doh.key"
path = "/atc"
upstream = ["52.119.40.100:53","52.119.40.101:53",]
timeout = 60
tries = 10
tcp_only = false
verbose = false
EOF

	cat >> /tmp/$SYSUSER  << EOF
### Renew certificates
42 0,12 * * * python -c 'import random; import time; time.sleep(random.random() * 3600)' && /usr/bin/certbot renew && if ! cmp -s /etc/letsencrypt/live/$HOST/fullchain.pem $DOH_ROOT/ssl/doh.crt; then cp /etc/letsencrypt/live/$HOST/fullchain.pem $DOH_ROOT/ssl/doh.crt && cp /etc/letsencrypt/live/$HOST/privkey.pem $DOH_ROOT/ssl/doh.key && killall -9 doh-server; fi
EOF

fi

crond
$DOH_ROOT/bin/doh-server -conf $DOH_ROOT/etc/doh-server.conf