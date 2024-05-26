FROM ubuntu:jammy

ARG LLVM_VERSION=18

# copy scripts
COPY . /

# run installation script
RUN ./install.sh --llvm $LLVM_VERSION

# set entrypoint bootstrap scripts
ENTRYPOINT ./bootstrap.sh --llvm $LLVM_VERSION
