#!/bin/bash

SHORT=l:g:
LONG=llvm:,gcc:
OPTS=$(getopt -o $SHORT: --long $LONG: -- "$@")

eval set -- "$OPTS"

LLVM=
GCC=

while true; do
  case "$1" in
    -l | --llvm ) LLVM="$2"; shift 2 ;;
    -g | --gcc ) GCC="$2"; shift 2 ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if [ -z "$LLVM" ]; then
  echo "-l | --llvm version is undefined"
  exit 1
fi

if [ -z "$GCC" ]; then
  echo "-g | --gcc version is undefined"
  exit 1
fi

echo "Installing packages from standard repositories"
apt-get update -qq && export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends \
        software-properties-common apt-utils \
        wget curl file gpg \
        build-essential ccache \
        git \
        python3 python3-pip \
        xorriso \
        gcc-"$GCC" g++-"$GCC" \
        qemu-system-x86 qemu-system-arm

echo "Installing packages from pip"
pip3 install cmake
pip3 install meson
pip3 install ninja
pip3 install gcovr
pip3 install config-pkg
pip3 install xbstrap

echo "Installing Taskfile"
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

echo "Installing LLVM"
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
./llvm.sh "$LLVM" all
