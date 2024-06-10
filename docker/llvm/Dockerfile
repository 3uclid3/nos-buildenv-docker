FROM ubuntu:noble

ARG LLVM_VERSION=18

COPY install.sh /

RUN chmod +x /install.sh && \
    /install.sh --llvm $LLVM_VERSION && \
    rm /install.sh

# ensure we have pipx
ENV PATH="/root/.local/bin:${PATH}"

CMD ["bash"]
