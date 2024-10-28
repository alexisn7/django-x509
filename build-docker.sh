#!/bin/bash

set -e

get_architecture() {
    # Get the system architecture
    arch=$(uname -m)

    # Determine architecture type
    case "$arch" in
        x86_64)
            echo "amd64"
            ;;
        armv7l)
            echo "arm32v7"
            ;;
        aarch64)
            echo "arm64v8"
            ;;
        *)
            echo "Error: Unsupported or unknown architecture ($arch)"
            return 1
            ;;
    esac
}


architecture=$(get_architecture)
if [ $? -eq 0 ]; then
    echo "Detected architecture: $architecture"
else
    echo "Failed to detect a supported architecture."
fi


docker build --build-arg ARCH=$architecture -t openwisp/djangox509 .


#sudo docker run -it -p 8000:8000 openwisp/djangox509