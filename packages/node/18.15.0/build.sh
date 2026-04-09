#!/bin/bash
source /arch-detect.sh

arch=$(get_arch)
case "$arch" in
    amd64)
        tarball="node-v18.15.0-linux-x64.tar.xz"
        ;;
    arm64)
        tarball="node-v18.15.0-linux-arm64.tar.xz"
        ;;
    *)
        echo "Unsupported architecture: $arch"
        exit 1
        ;;
esac

curl -L "https://nodejs.org/dist/v18.15.0/${tarball}" -o node.tar.xz
tar xf node.tar.xz --strip-components=1
rm node.tar.xz