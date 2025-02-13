#!/bin/bash

version=$1

github_release_api="https://api.github.com/repos/awawa-dev/HyperHDR/releases"

# Fetch the release data for a specific version
fetch_release_data() {
  local version=$1

  wget -qO- "${github_release_api}/tags/v${version}"
}

# Fetch the latest version from GitHub API
fetch_latest_version() {
  wget -qO- "${github_release_api}/latest" | grep '"tag_name":' | sed -E 's/.*"tag_name": "v?([^"]+)".*/\1/'
}

# Get the distribution name
get_distro_name() {
  . /etc/os-release && echo "$VERSION_CODENAME"
}

# Get the download URL from release data
get_download_url() {
  local release_data=$1
  local version=$2
  local distro_name=$3

  # First try to find a distro-specific download URL
  download_url=$(echo "$release_data" | grep "browser_download_url.*${distro_name}.*-$(uname -m).deb")

  if [ -z "$download_url" ]; then
    # If no distro-specific URL is found, try the generic Linux one
    download_url=$(echo "$release_data" | grep "browser_download_url.*${version}-Linux-$(uname -m).deb")
  fi

  # If no download URL found, exit with an error
  if [ -z "$download_url" ]; then
    echo "Error: No download URL found for ${distro_name} and architecture $(uname -m)"
    exit 1
  fi

  # Extract the URL
  echo "$download_url" | sed -E 's/.*"browser_download_url": "([^"]+)".*/\1/'
}


# Main logic
if [ -n "${version}" ]; then
  # Fetch the release data for the specified version
  release_data=$(fetch_release_data "$version")

  if [ -z "$release_data" ]; then
    echo "Error: Version ${version} does not exist"
    exit 1
  fi
else
  version=$(fetch_latest_version)
  echo "Using latest version ${version}"
  release_data=$(fetch_release_data "$version")
fi

# Get distribution name (e.g., bookworm)
distro_name=$(get_distro_name)

# Get the download URL
download_url=$(get_download_url "$release_data" "$version" "$distro_name")
echo "Download URL: $download_url"

# Download binary
wget -q $download_url

