#!/bin/sh

/etc/init.d/mongodb start

exec "$@"
