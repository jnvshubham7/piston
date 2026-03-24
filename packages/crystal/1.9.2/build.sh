#!/bin/bash

PREFIX=$(realpath $(dirname $0))

source /arch-detect.sh
armv=$(uname -m | grep -q aarch64 && echo arm64 || echo x86_64)
curl -L "https://github.com/crystal-lang/crystal/releases/download/1.9.2/crystal-1.9.2-1-linux-${armv}.tar.gz" -o crystal.tar.gz
tar xzf crystal.tar.gz --strip-components=1
rm crystal.tar.gz
