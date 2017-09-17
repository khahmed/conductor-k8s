#!/bin/sh
export CWS_TOP=/opt/ibm/spectrumcomputing
export CLUSTERADMIN=egoadmin
export HOSTNAME=`hostname`

# patch to support kernel 4
sed -i 's|$version = "3"|$version = "3" -o $version = "4"|g' ${CWS_TOP}/kernel/conf/profile.ego

/bin/su -c "source $CWS_TOP/kernel/conf/profile.ego; egoconfig join $MASTERNAME -f" egoadmin
if [ "$MASTERNAME" == `hostname` ]; then
    cat /var/tmp/cfc/key1.dat >> /tmp/license.dat
    sed -i -e '$a\' /tmp/license.dat
    cat /var/tmp/cfc/key2.dat >> /tmp/license.dat
    /bin/su -c "source $CWS_TOP/profile.platform; egoconfig mghost /shared -f; source $CWS_TOP/profile.platform; egoconfig setentitlement /tmp/license.dat" egoadmin
fi

source $CWS_TOP/profile.platform

chown  $CLUSTERADMIN $CWS_TOP/kernel/work 
chgrp  $CLUSTERADMIN $CWS_TOP/kernel/work 
egosh ego start

i=1
while [ "$i" -ne 0 ]
do
   sleep 10
done

