#!/bin/bash

pushd "$(dirname "$0")" > /dev/null

[ -f .env ] && source .env
[ -n "$IMAGE_VERSION" ] || { echo "Error: IMAGE_VERSION is not set!"; exit 1; }

docker build \
  --rm \
  --build-arg IMAGE_VERSION=${IMAGE_VERSION} \
  --tag thomy90/hyperhdr:${IMAGE_VERSION} \
  .

popd > /dev/null

