#!/bin/bash
#ATC DOH start script

SYSUSER=`whoami | awk '{print $1}'`
DOH_ROOT="/opt/doh"
HOST=`hostname -f`

if [ ! -f $DOH_ROOT/etc/doh-server.conf ]; then
    cat >> $DOH_ROOT/etc/doh-server.conf  << EOF
listen = ["*:443",]
#cert = "/opt/doh/ssl/doh.crt"
#key = "/opt/doh/ssl/doh.key"
path = "/atc"
upstream = ["52.119.40.100:53","52.119.40.101:53",]
timeout = 60
tries = 10
tcp_only = false
verbose = false
EOF

fi

if [ ! -f $DOH_ROOT/ssl/doh.crt ]; then
	certbot-auto certonly --standalone -d $HOST -d www.$HOST
fi

$DOH_ROOT/bin/doh-server -conf $DOH_ROOT/etc/doh-server.conf