#!/usr/bin/env bash
source /arch-detect.sh

machine=$(uname -m)
case "$machine" in
    x86_64)
        java_arch="x64"
        ;;
    aarch64|arm64)
        java_arch="aarch64"
        ;;
    *)
        echo "Unsupported architecture: $machine"
        exit 1
        ;;
esac

curl "https://download.java.net/java/GA/jdk15.0.2/0d1cfde4252546c6931946de8db48ee2/7/GPL/openjdk-15.0.2_linux-${java_arch}_bin.tar.gz" -o java.tar.gz
tar xzf java.tar.gz --strip-components=1
rm java.tar.gz

