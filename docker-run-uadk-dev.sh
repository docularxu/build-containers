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

# Prefixes of devices to be mapped with their target indices
declare -A device_target_indices=(
    ["hisi_hpre"]="0 1"
    ["hisi_sec2"]="2 3"
    ["hisi_zip"]="4 5"
)

device_args=""
for device_prefix in "${!device_target_indices[@]}"; do
    # Get target indices for the current device type
    read -ra targets <<< "${device_target_indices[$device_prefix]}"
    target_index=0

    # Find all devices that match the prefix
    for device_path in /dev/${device_prefix}-*; do
        if [[ -e $device_path && $target_index -lt ${#targets[@]} ]]; then
            # Extract the actual device index
            actual_index=$(echo "$device_path" | grep -o '[^-]*$')
            # Construct and append the device mapping, mapping actual index to the specified target index
            device_args+="--device=${device_path}:/dev/${device_prefix}-${targets[target_index]}:rwm "
            ((target_index++))
        fi
    done
done

# Remove trailing space
device_args=$(echo $device_args | xargs)

# Common volume mount
volume="-v /home/guodong/working:/mnt"

# Determine the Docker image based on the first argument
case "$1" in
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
