#!/bin/bash
set -e

if [ -n "$1" ]; then
  exec "$@"
else
  /usr/sbin/smokeping --nodaemon
fi
