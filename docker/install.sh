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
        build-essential ccache git python3 python3-pip xorriso qemu-system-x86 qemu-system-arm

echo "Installing packages from pip"
pip3 install meson
pip3 install ninja
pip3 install gcovr
pip3 install xbstrap

echo "Installing Taskfile"
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

echo "Installing LLVM"
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
./llvm.sh "$LLVM" all

update-alternatives --install /usr/bin/clang clang /usr/bin/clang-"$LLVM" 100
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-"$LLVM" 100

update-alternatives --install /usr/bin/lld lld /usr/bin/lld-"$LLVM" 100

update-alternatives --install /usr/bin/llvm-ar llvm-ar /usr/bin/llvm-ar-"$LLVM" 100
update-alternatives --install /usr/bin/llvm-strip llvm-strip /usr/bin/llvm-strip-"$LLVM" 100

update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-"$LLVM" 100

update-alternatives --install /usr/bin/cc cc /usr/bin/clang-"$LLVM" 100
update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-"$LLVM" 100
