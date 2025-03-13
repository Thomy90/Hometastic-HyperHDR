#!/bin/bash -e

(
    cd "$(dirname "$0")"

    [ -f .env ] && source .env

    docker push thomy90/hyperhdr:${IMAGE_VERSION:-latest}
)
