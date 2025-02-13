ARG BASE_IMAGE="debian:bookworm-slim"

FROM ${BASE_IMAGE}

ARG VERSION

COPY download-deb.sh /

RUN apt-get update && apt-get install -y --no-install-recommends \
  wget \
  ca-certificates \
  && /download-deb.sh -b /tmp ${VERSION} \
  && apt-get install -y --no-install-recommends \
  /tmp/hyperhdr.deb \
  && rm -rf /var/lib/apt/lists/* \
  && rm /download-deb.sh \
  && rm /tmp/hyperhdr.deb

RUN apt-get update && apt-get install -y --no-install-recommends \
  libx11-6 \
  libasound2 \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 8090 8092

ENTRYPOINT ["/usr/bin/hyperhdr"]
