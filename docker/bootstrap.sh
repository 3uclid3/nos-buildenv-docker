#!/bin/bash

SHORT=l
LONG=llvm
OPTS=$(getopt -o $SHORT: --long $LONG: -- "$@")

eval set -- "$OPTS"

LLVM=

while true; do
  case "$1" in
    -l | --llvm ) LLVM="$2"; shift 2 ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if [ -z "$LLVM" ]; then
  echo "-l | --llvm is undefined"
  exit 1
fi
