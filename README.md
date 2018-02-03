# Dockerfile for rust-nightly

Current rust toolchain version: nightly-2018-02-02-x86_64-unknown-linux-gnu

## Using the image from Docker Hub

```sh
$ docker pull 57rodneys/rust-nightly:latest
```

## Building the image

```sh
$ git clone git@github.com:devlato/rust-nightly.git
$ cd ./rust-nightly
$ docker build .
```
