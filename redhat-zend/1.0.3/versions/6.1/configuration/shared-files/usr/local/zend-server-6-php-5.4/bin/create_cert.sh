#!/bin/sh

PATH=$ZCE_PREFIX/bin:$PATH
mkdir -p $ZCE_PREFIX/etc/tls/certs
FQDN=`hostname`
if [ "$FQDN" = "" ];then
    FQDN=localhost.localdomain
fi
if [ -f $ZCE_PREFIX/etc/openssl.cnf ];then
    export OPENSSL_CONF="$ZCE_PREFIX/etc/openssl.cnf"
fi
if [ ! -f $ZCE_PREFIX/etc/tls/certs/lighttpd.pem ] ; then
    umask 077
    openssl req -new -x509 -days 365 -nodes \
                -out $ZCE_PREFIX/etc/tls/certs/lighttpd.pem  \
                -keyout $ZCE_PREFIX/etc/tls/certs/lighttpd.pem << EOF >/dev/null 2>&1
--
SomeState
SomeCity
SomeOrganization
SomeOrganizationalUnit
${FQDN}
root@${FQDN}
EOF
    if [ -f $ZCE_PREFIX/etc/tls/certs/lighttpd.pem ] ; then
	chmod 600 $ZCE_PREFIX/etc/tls/certs/lighttpd.pem
    else
	echo "$ZCE_PREFIX/etc/tls/certs/lighttpd.pem wasn't created, please try and recreate it manually"
	echo "with the script $0"
    fi 
fi
