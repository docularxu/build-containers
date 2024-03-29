#!/bin/bash

set -x

# Check if no arguments are provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 [ubuntu/euler/2203/2309] [docker_name]"
    exit 1
fi

# Display the provided arguments
echo "Distribution: $1"
echo "Docker Name: $2"

# Prefixes of devices to be mapped
declare -A device_prefixes=(
  ["hisi_hpre"]=""
  ["hisi_sec2"]=""
  ["hisi_zip"]=""
)

device_args=""
for device_prefix in "${!device_prefixes[@]}"; do
  # Find all devices that match the prefix
  for device_path in /dev/${device_prefix}-*; do
    if [[ -e $device_path ]]; then
      # Construct the device mapping directly using the device path
      device_args+="--device=${device_path}:${device_path}:rwm "
    fi
  done
done

# Remove trailing space
device_args=$(echo $device_args | xargs)

# Common volume mount
volume="-v /home/guodong/working:/mnt"

# Determine the Docker image based on the first argument
case "$1" in
    "ubuntu-jdk-uadk")
        image="uadk-jdk-dev:ubuntu.2204"
        ;;
    "ubuntu")
        image="uadk-dev:ubuntu.2204"
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
docker run -it --name "$2" $device_args $volume "$image" bash
