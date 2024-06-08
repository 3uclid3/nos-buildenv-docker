FROM ubuntu:noble

ARG LLVM_VERSION=18
ARG GCC_VERSION=14

COPY install.sh /

RUN chmod +x /install.sh && \
    /install.sh --llvm $LLVM_VERSION --gcc $GCC_VERSION && \
    rm /install.sh

CMD ["bash"]
