#!/bin/bash

[ ! $(id -u) = 0 ] && {
	echo "Please run as the root user."
	exit 0
}

work=$(dirname $0)
insdir=/etc/os-tools

mkdir -p $insdir
rm -rf $insdir/*

cp -p $work/complete-os-rc $insdir/
cp -p $work/os-functions $insdir/
cp -p $work/os-tools $insdir/
cp -pr $work/complete-os $insdir/

which openstack > /dev/null 2>&1 && openstack complete > $insdir/complete-os/openstack 2> /dev/null
which jq > /dev/null 2>&1 || nojq_flag=1

load_command="[ -f $insdir/os-tools ] && . $insdir/os-tools"
echo "$load_command" > /etc/profile.d/os-tools.sh

echo "INSTALL COMPLETED."
echo "Please load '/etc/profile.d/os-tools.sh' file, or re-login."

[ ! -z $nojq_flag ] && {
	echo "WARNING: jq is not installed."
	echo " Please install jq, and reload '/etc/profile.d/os-tools.sh'."
}
