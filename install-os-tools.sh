#!/bin/bash

work=$(dirname $0)
insdir=/etc/os-tools

mkdir -p $insdir
rm -rf $insdir/*

cp -p $work/complete-os-rc $insdir/
cp -p $work/os-functions $insdir/
cp -p $work/os-tools $insdir/
cp -pr $work/complete-os $insdir/

which openstack > /dev/null 2>&1 && openstack complete > $insdir/complete-os/openstack 2> /dev/null
which jq > /dev/null 2>&1 || cp -p $work/jq /usr/local/sbin/ 2> /dev/null

load_command="[ -f $insdir/os-tools ] && . $insdir/os-tools"
grep_str=$(echo "$load_command" | sed "s/\\[/\\\\[/g" | sed "s/\\]/\\\\]/g")

key_line=$(grep -n "$grep_str" ~/.bashrc | sed 's/:.*//g')
[ ! -z "$key_line" ] && sed -i "${key_line}d" ~/.bashrc
echo "$load_command" >> ~/.bashrc
echo "Please reload .bashrc file."
