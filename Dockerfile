FROM ubuntu:18.04
ENV RUSTUP_HOME $HOME/.rustup
ENV CARGO_HOME $HOME/.cargo
ENV PATH $PATH:$CARGO_HOME/bin
MAINTAINER Denis Tokarev

RUN apt-get update \
  && apt-get install -y \
    make=4.1-9.1 \
    git=1:2.15.1-1ubuntu2 \
    gcc=4:7.2.0-1ubuntu1 \
    curl=7.57.0-1ubuntu1 \
  && rm -rf /var/lib/apt/lists/*
RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly -y
RUN rustup default nightly
RUN rustup update
RUN rustup toolchain install nightly-2018-02-02-x86_64-unknown-linux-gnu
