FROM alpine:3.7
LABEL maintainer="github@devlato.com"

ENV \
  RUSTUP_HOME=${HOME}/.rustup\
  CARGO_HOME=${HOME}/.cargo\
  PATH=${PATH}:${CARGO_HOME}/bin\
  \
  SW_GLIBC_VERSION=2.27-r0\
  SW_GLIBC_KEY_URL=https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub\
  SW_GLIBC_KEY_PATH=/etc/apk/keys/sgerrand.rsa.pub\
  SW_GLIBC_BASE_URL=https://github.com/sgerrand/alpine-pkg-glibc/releases/download\
  SW_GLIBC_PACKAGES="glibc glibc-bin glibc-i18n"\
  SW_GLIBC_TMP_FILE_NAME=/tmp/glibc-${SW_GLIBC_VERSION}.apk\
  \
  SW_MAKE_VERION=4.2.1-r0\
  SW_CURL_VERION=7.58.0-r0\
  SW_OPENSSL_VERION=1.0.2n-r0\
  SW_CS_CERTIFICATES_VERION=20171114-r0\
  SW_LIBGCC_VERION=6.4.0-r5\
  SW_ZLIB_VERION=1.2.11-r1\
  \
  SW_RUST_VERSION=nightly-2018-02-02-x86_64-unknown-linux-gnu

RUN \
  apk update && \
  \
  wget -q -O $SW_GLIBC_KEY_PATH $SW_GLIBC_KEY_URL && \
  for GLIBC_PACKAGE in $SW_GLIBC_PACKAGES; do \
    wget "$SW_GLIBC_BASE_URL/$SW_GLIBC_VERSION/$GLIBC_PACKAGE-$SW_GLIBC_VERSION.apk" -O $SW_GLIBC_TMP_FILE_NAME && \
    apk add $SW_GLIBC_TMP_FILE_NAME && \
    rm -f $SW_GLIBC_TMP_FILE_NAME; \
  done && \
  \
  apk --no-cache -v add --update \
    make=4.2.1-r0 \
    curl=7.58.0-r0 \
    openssl=1.0.2n-r0 \
    ca-certificates=20171114-r0 \
    libgcc=6.4.0-r5 \
    zlib=1.2.11-r1 && \
  \
  rm -rf /var/cache/apk/*

ENV PATH ${PATH}:${CARGO_HOME}/bin

RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain $SW_RUST_VERSION -y

CMD ["rustc", "--version"]
