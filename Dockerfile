ARG BASE_IMAGE="dhi.io/debian-base:trixie-debian13"

FROM ${BASE_IMAGE} AS fetch

ARG VERSION

COPY download-deb.sh /

RUN apt-get update && apt-get install -y --no-install-recommends \
  wget \
  ca-certificates \
  && /download-deb.sh -b /tmp ${VERSION} \
  && rm -rf /var/lib/apt/lists/* 


FROM ${BASE_IMAGE}

COPY --from=fetch /tmp/hyperhdr.deb /tmp/hyperhdr.deb

RUN apt-get update && apt-get install -y --no-install-recommends \  
  /tmp/hyperhdr.deb \
  && rm -rf /var/lib/apt/lists/* \
  && rm /tmp/hyperhdr.deb

RUN apt-get update && apt-get install -y --no-install-recommends \
  libx11-6 \
  libasound2 \
  libbrotli1 \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 8090 8092

ENTRYPOINT ["/usr/bin/hyperhdr"]
