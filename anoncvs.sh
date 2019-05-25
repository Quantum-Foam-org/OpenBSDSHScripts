#!/bin/sh

openbsdVersion='OPENBSD_6_5'
cvsup="cvs -d anoncvs@anoncvs4.usa.openbsd.org:/cvs  -q up -Pd -r$openbsdVersion"
cd /usr/ports
echo $cvsup
#cd /usr/src
#echo `$cvsup`
#cd /usr/xenocara
#echo `$cvsup`
