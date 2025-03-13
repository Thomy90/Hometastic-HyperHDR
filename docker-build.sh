#!/bin/bash -e

(
    cd "$(dirname "$0")"

    [ -f .env ] && source .env

    docker build \
      --rm \
      --build-arg VERSION=${IMAGE_VERSION} \
      --tag thomy90/hyperhdr:${IMAGE_VERSION:-latest} \
      .
)

