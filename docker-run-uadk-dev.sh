#!/bin/bash

# Check if no arguments are provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 [ubuntu/euler/2203/2309] [docker_name]"
    exit 1
fi

# Display the provided arguments
echo "Distribution: $1"
echo "Docker Name: $2"

# Common devices to be mapped
devices=(
    "--device=/dev/hisi_hpre-0:/dev/hisi_hpre-0:rwm"
    "--device=/dev/hisi_hpre-1:/dev/hisi_hpre-1:rwm"
    "--device=/dev/hisi_sec2-2:/dev/hisi_sec2-2:rwm"
    "--device=/dev/hisi_sec2-3:/dev/hisi_sec2-3:rwm"
    "--device=/dev/hisi_zip-4:/dev/hisi_zip-4:rwm"
    "--device=/dev/hisi_zip-5:/dev/hisi_zip-5:rwm"
)

# Common volume mount
volume="-v /home/linaro/p9root:/mnt"

# Determine the Docker image based on the first argument
case "$1" in
    "ubuntu")
        image="ubuntu"
        ;;
    "euler")
        image="openeuler/openeuler:latest"
        ;;
    "2203")
        image="openeuler/openeuler:22.03"
        ;;
    "2309")
        echo "Launching OpenEuler 23.09 container named $2..."
        # The following line is an alternative configuration, commented out for reference
        # docker run -it --name $2 -v /home/linaro/p9root:/mnt openeuler/openeuler:23.09 bash
        image="openeuler/openeuler:23.09"
        ;;
    *)
        echo "Invalid distribution: $1. Please specify ubuntu, euler, 2203, or 2309."
        exit 1
        ;;
esac

# Run the Docker container with the specified configuration
echo "Launching $image container named $2..."
docker run -it --name "$2" ${devices[@]} $volume "$image" bash
