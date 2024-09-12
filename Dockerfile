FROM ubuntu:devel

RUN apt-get update && apt-get install -y \
    vim \
    git \
    spim \
    just \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]