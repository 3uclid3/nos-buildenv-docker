FROM ubuntu:noble

ARG LLVM_VERSION=18

COPY install.sh /

RUN chmod +x /install.sh && \
    /install.sh --llvm $LLVM_VERSION && \
    rm /install.sh

CMD ["bash"]
