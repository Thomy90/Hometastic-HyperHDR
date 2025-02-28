# Hometastic-HyperHDR

## Overview

Hometastic-HyperHDR is a Dockerized setup of [HyperHDR](https://github.com/awawa-dev/HyperHDR), an open-source ambient lighting implementation.
This repository provides scripts and configurations to build and deploy HyperHDR using Docker, facilitating seamless integration with your home entertainment system.

## Prerequisites

- Docker: Ensure Docker is installed and running on your system.
- Docker Compose: Required to start the Docker container with configurable options.
- Capture Device: A USB video capture card is necessary for grabbing video signals.

## Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/Thomy90/Hometastic-HyperHDR.git
cd Hometastic-HyperHDR
```

### 2. Create Docker network
```bash
docker network create --opt com.docker.network.bridge.name=reverse-proxy reverse-proxy
```
This network is used not only for HyperHDR but also for additional Hometastic services that may require access to the reverse proxy.

### 3. Check capture device
Before starting the container, ensure that the USB capture device is accessible. You can do this by running the following command to check if the device is listed:
```bash
ls /dev/video*
```
If your capture device is properly connected, you should see it listed as /dev/video0 or similar. If not, check your device's connection.


### 2. Run HyperHDR with Docker Compose
```bash
docker-compose up -d
```

### 3. Access HyperHDR
Once running, HyperHDR's web interface can be accessed at:
```
http://localhost:9091
```

## Resources

- **HyperHDR Official Repository**: [https://github.com/awawa-dev/HyperHDR](https://github.com/awawa-dev/HyperHDR)
- **HyperHDR Documentation**: [https://www.hyperhdr.eu/](https://www.hyperhdr.eu/)

For detailed information on HyperHDR's features and configuration, refer to the official documentation.



