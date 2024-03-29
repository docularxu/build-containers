# kernel-build-containers: Dockerfile.me

Dockerfiles which can be used to create docker container images for linux kernel build. To create a Docker image for the kernel build, use the following command:

    docker build -t kernel-build-container:debian-bullseye-20210208-v7 - < Dockerfile.me
    docker run -it -v /home/guodong/linux.git:/linux.git \
                   -v /home/guodong/linux.buildout:/linux.buildout \
                   kernel-build-container:debian-bullseye-20210208-v7 /bin/bash

# OpenSSL v3.0 containers: Dockerfile.openssl.v3

This dockerfile can be used to create a build and test environment for OpenSSL v3.0+

    docker build -t ossl3.0:debian-bullseye-221004 - < Dockerfile.openssl.v3
    docker run -it -v /home/docularxu/docker-volume:/docker-volume  ossl3.0:debian-bullseye-221004 /bin/bash

# JDK and Bisheng JDK build environment: Dockerfile.oeuler.2303.jdk-dev

(Note: Dockerfile.ubuntu.2204.uadk-dev can also be used for JDK build and development.)

This Dockerfile is for BishengJDK 8 build and testing. It based on openEuler 23.03, pre-installed with JDK built dependencies.

    docker build -t jdk-dev:openeuler.2303 - < Dockerfile.oeuler.2303.jdk-dev
    docker run -it -v /home/guodong/working:/mnt/working jdk-dev:openeuler.2303 /bin/bash

# UADK build and testing in a docker container: Dockerfile.ubuntu.2204.uadk-dev

This Dockerfile is used to create a build and test environment for UADK and it is based on ubuntu:22.04 image dated on 8/Mar/2024.

    docker build -f Dockerfile.ubuntu.2204.uadk-dev . -t uadk-jdk-dev:ubuntu.2204

To consume the image built, one need to run the following shell script to map hardware accelerators into the docker container

    docker-run-uadk-dev.sh ubuntu <give_it_a_name>

# Useful docker commands

To manoeuvre the previously created containers, use these docker commands:

    docker ps
    docker ps -a -n 10
    docker stop [container_name]
    docker start [container_name] -ia

or when you want to open another shell access to an existing container, run

    docker exec -it [container_name] /bin/bash

To list available local docker images, run

    docker images
