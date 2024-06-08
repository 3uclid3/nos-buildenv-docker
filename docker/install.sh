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

echo "Installing packages from standard repositories"
apt-get update -qq && export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends software-properties-common apt-utils wget curl file gpg \
        build-essential ccache git python3 python3-pip pipx xorriso qemu-system-x86 qemu-system-arm

echo "Installing packages from pip"
pipx install cmake
pipx install meson
pipx install ninja
pipx install gcovr
pipx install config-pkg
pipx install xbstrap

echo "Installing Taskfile"
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

echo "Installing LLVM"
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
./llvm.sh "$LLVM" all
