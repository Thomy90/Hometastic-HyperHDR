ARG BASE_IMAGE="debian:12.8-slim"

FROM ${BASE_IMAGE}

RUN apt-get update && apt-get install -y --no-install-recommends \
  wget \
  ca-certificates \
  && wget -qO /etc/apt/keyrings/hyperhdr.asc https://awawa-dev.github.io/hyperhdr.public.apt.gpg.key \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/hyperhdr.asc] https://awawa-dev.github.io $(. /etc/os-release && echo "$VERSION_CODENAME") main" | tee /etc/apt/sources.list.d/hyperhdr.list \
  && apt-get update && apt-get install -y --no-install-recommends \
  hyperhdr \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
  libx11-6 \
  libasound2 \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 8090 8092

ENTRYPOINT ["/usr/bin/hyperhdr"]
