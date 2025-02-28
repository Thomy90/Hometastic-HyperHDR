#!/bin/bash

pushd "$(dirname "$0")" > /dev/null

[ -f .env ] && source .env
[ -n "$IMAGE_VERSION" ] || { echo "Error: IMAGE_VERSION is not set!"; exit 1; }

docker push thomy90/hyperhdr:${IMAGE_VERSION}

popd > /dev/null
