FROM ubuntu:18.04
LABEL maintainer="github@devlato.com"

ENV \
  RUSTUP_HOME=${HOME}/.rustup\
  CARGO_HOME=${HOME}/.cargo\
  PATH=${PATH}:${CARGO_HOME}/bin\
  \
  SW_MAKE_VERSION=4.1-9.1\
  SW_CURL_VERSION=7.58.0-2ubuntu1\
  SW_OPENSSL_VERSION=1.0.2n-1ubuntu1\
  SW_CA_CERTIFICATES_VERSION=20170717\
  SW_GCC_VERSION=4:7.2.0-1ubuntu1\
  SW_LIBC_VERSION=2.26-0ubuntu2\
  \
  SW_RUST_VERSION=nightly-2018-02-02-x86_64-unknown-linux-gnu

RUN \
  apt-get update && \
  apt-get install --no-install-recommends --no-install-suggests -y \
    make=$SW_MAKE_VERSION \
    curl=$SW_CURL_VERSION \
    openssl=$SW_OPENSSL_VERSION \
    ca-certificates=$SW_CA_CERTIFICATES_VERSION \
    gcc=$SW_GCC_VERSION \
    libc6=$SW_LIBC_VERSION \
    libc6-dev=$SW_LIBC_VERSION && \
  apt-get autoclean && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV PATH ${PATH}:${CARGO_HOME}/bin

RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain $SW_RUST_VERSION -y

CMD ["rustc", "--version"]
