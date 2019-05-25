#!/bin/sh

openbsdVersion='OPENBSD_6_5'
cvsServer='anoncvs@anoncvs4.usa.openbsd.org:/cvs'
cvsup="cvs -d ${cvsServer} -q up -Pd -r${openbsdVersion}"
cd /usr/ports
echo $(${cvsup})
#cd /usr/src
#echo `$cvsup`
#cd /usr/xenocara
#echo `$cvsup`
