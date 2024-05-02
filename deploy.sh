#!/usr/bin/env bash

LOCK_FILE="$(pwd)/deploy-if-changed.lock"
cd /home/ajaykrishna/tmpdir/friendly-octo-dollop

flock -n $LOCK_FILE ./deploy-if-changed.sh >> ./deploy-if-changed.log 2>&1
