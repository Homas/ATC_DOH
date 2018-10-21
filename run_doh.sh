#!/bin/bash
#ATC DOH start script

SYSUSER=`whoami | awk '{print $1}'`
DOH_ROOT="/opt/doh"

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

fi

if [ ! -f $DOH_ROOT/ssl/doh.crt ]; then
	certbot -n certonly --standalone -d $HOSTN --agree-tos --email $EMAIL
	cp /etc/letsencrypt/live/doh.ioc2rpz.com/fullchain.pem $DOH_ROOT/ssl/doh.crt
	cp /etc/letsencrypt/live/doh.ioc2rpz.com/privkey.pem $DOH_ROOT/ssl/doh.key
fi

$DOH_ROOT/bin/doh-server -conf $DOH_ROOT/etc/doh-server.conf