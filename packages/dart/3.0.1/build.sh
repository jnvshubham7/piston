#!/usr/bin/env bash
source /arch-detect.sh

arch=$(get_arch)
case "$arch" in
    amd64)
        sdk="dartsdk-linux-x64-release.zip"
        ;;
    arm64)
        sdk="dartsdk-linux-arm64-release.zip"
        ;;
    *)
        echo "Unsupported architecture: $arch"
        exit 1
        ;;
esac

curl -L "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.1/sdk/${sdk}" -o dart.zip

unzip dart.zip
rm dart.zip

cp -r dart-sdk/* .
rm -rf dart-sdk

chmod -R +rx bin