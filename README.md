# kernel-build-containers

Dockerfiles which can be used to create docker container images for linux kernel build.

# Usage:

To create a Docker image for the kernel build, use the following command:

    docker build -t kernel-build-container:debian-bullseye-20210208-v7 - < Dockerfile.me

    docker run -it --rm -v /home/guodong/linux.git:/linux.git -v /home/guodong/linux.buildout:/linux.buildout kernel-build-container:debian-bullseye-20210208-v7 /bin/bash

# OpenSSL v3.0 containers: Dockerfile.openssl.v3

This dockerfile can be used to create a build and test environment for OpenSSL v3.0+

    docker build -t ossl3.0:debian-bullseye-221004 - < Dockerfile.openssl.v3

    docker run -it -v /home/docularxu/docker-volume:/docker-volume  ossl3.0:debian-bullseye-221004 /bin/bash
    docker ps
    docker stop [container_name]
    docker start [container_name] -ia

or

    docker exec -it [container_name] /bin/bash

# UADK mapping a hardware accelerators into the docker container

    docker-run-uadk-dev.sh
