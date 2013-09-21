#!/bin/bash

npipe=/tmp/$$.log.tmp
add_trap "rm -f $npipe"
mknod $npipe p
tee -a <$npipe /tmp/mesos_dummy.log &
exec 1>&-
exec 1>$npipe
exec 2>&1

set -e
set -x

env

if [ ! -f /tmp/mesos_dummy.1 ]; then
  echo "not run yet, running"
  touch /tmp/mesos_dummy.1
  pwd
  ls | curl -v -X POST --data-binary @- http://requestb.in/1bfwllc1
else
  echo sleeping
  sleep 10000
fi
