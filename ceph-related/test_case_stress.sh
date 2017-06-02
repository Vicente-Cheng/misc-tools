#!/bin/bash
#
# befor you use this script, you need to run-make-check.sh once
# works on jewel branch (for backport testing)
#


#pre-config
abs_builddir=<ceph_abs_path>/src
abs_srcdir=<ceph_abs_path>/src
abs_top_builddir=<ceph_abs_path>
abs_top_srcdir=<ceph_abs_path>

export CEPH_ROOT="$abs_top_srcdir"
export CEPH_BUILD_DIR="$abs_srcdir"
export CEPH_BIN="$abs_srcdir"
export CEPH_LIB="$abs_srcdir/.libs"
export PATH="$abs_srcdir:$PATH"

for i in $(seq 1 1 20)
do
	echo "working with $i times..."
	./test/<test scripts> > logfile.$i 2>&1
done
