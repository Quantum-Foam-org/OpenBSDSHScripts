#/bin/sh

for f in $(pkg_info | awk '{ print $1 }') ; do
    pkg_delete ${f}
done
