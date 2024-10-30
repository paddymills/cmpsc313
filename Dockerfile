FROM debian:unstable-slim

RUN apt-get update && apt-get install -y \
    vim \
    git \
    spim \
    just \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /src
WORKDIR "/src"
ENTRYPOINT ["/bin/bash"]