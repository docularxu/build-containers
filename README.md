# kernel-build-containers
Dockerfiles which can be used to create docker container images for linux kernel build.

Usage:
docker build -t kernel-build-container:debian-bullseye-20210208-v7 - < Dockerfile.me

docker run -it --rm -v /home/guodong/linux.git:/linux.git -v /home/guodong/linux.buildout:/linux.buildout kernel-build-container:debian-bullseye-20210208-v7 /bin/bash

