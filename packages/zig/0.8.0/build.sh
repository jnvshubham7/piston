#!/usr/bin/env bash
source /arch-detect.sh
arch=$(uname -m | sed 's/x86_64/x86_64/; s/aarch64/aarch64/; s/armv7l/armv7/')

mkdir -p bin
cd bin/

curl -L "https://ziglang.org/download/0.8.0/zig-linux-${arch}-0.8.0.tar.xz" -o zig.tar.xz
tar xf zig.tar.xz --strip-components=1
rm zig.tar.xz

cd ../
