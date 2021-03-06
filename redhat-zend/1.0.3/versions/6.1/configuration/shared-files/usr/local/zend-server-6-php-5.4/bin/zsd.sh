#!/bin/bash 
NAME="ZendServerDaemon"


#Don't include zce.rc in openshift the gear will create it's own variables
if [ -f $ZCE_PREFIX/bin/shell_functions.rc ];then
    . $ZCE_PREFIX/bin/shell_functions.rc
else
    echo "$ZCE_PREFIX/bin/shell_functions.rc doesn't exist!"
    exit 1;
fi
#check_root_privileges
WEB_USER=$(whoami)
. ${ZCE_PREFIX}/bin/shell_functions.rc
WD_INI=${ZCE_PREFIX}/etc/watchdog-zsd.ini
export ZEND_TMPDIR=${ZCE_PREFIX}/tmp
WATCHDOG="${ZCE_PREFIX}/bin/watchdog -c $WD_INI"
TMPDIR=${ZCE_PREFIX}/tmp
TMPDIR=${ZEND_TEMPDIR}
BINARY=zsd



start()
{
    launch
}

stop()
{
    _kill
}
status()
{
    $WATCHDOG -i $BINARY
}
case "$1" in
	start)
		start
	#	sleep 1
                status
		;;
	stop)
		stop
		;;
	restart)
		stop
	#	sleep 1
		start
		;;
	status)
                status
		;;
	*)
		usage
esac

exit $?
