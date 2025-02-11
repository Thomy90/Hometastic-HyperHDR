#!/bin/bash

version=$1

if [ -n "${version}" ]; then

  wget --spider "https://api.github.com/repos/awawa-dev/HyperHDR/releases/tags/v${version}" 2>/dev/null
  if [[ $? -ne 0 ]]; then
    echo "Error: Version ${version} does not exist"
    unset version
  fi

fi

if [ -z "${version}" ]; then
  version=$(wget -qO- https://api.github.com/repos/awawa-dev/HyperHDR/releases/latest | grep '"tag_name":' | sed -E 's/.*"tag_name": "v?([^"]+)".*/\1/')
  echo "Using latest version ${version}"
fi

distro_name=$(. /etc/os-release && echo "$VERSION_CODENAME")
if wget -qO- https://api.github.com/repos/awawa-dev/HyperHDR/releases/tags/v${version} | grep -q "${distro_name}.*-$(uname -m).deb"; then
  download_url=$(wget -qO- https://api.github.com/repos/awawa-dev/HyperHDR/releases/tags/v${version} | grep "browser_download_url.*${distro_name}.*-$(uname -m).deb" | sed -E 's/.*"browser_download_url": "([^"]+)".*/\1/')
else
  download_url=$(wget -qO- https://api.github.com/repos/awawa-dev/HyperHDR/releases/tags/v${version} | grep "browser_download_url.*${version}-Linux-$(uname -m).deb" | sed -E 's/.*"browser_download_url": "([^"]+)".*/\1/')
fi

wget $download_url


