#!/usr/bin/env bash
source /arch-detect.sh
arch=$(uname -m | sed 's/x86_64/x86_64/; s/aarch64/aarch64/')

curl -L "https://sourceforge.net/projects/fbc/files/FreeBASIC-1.09.0/Binaries-Linux/FreeBASIC-1.09.0-linux-${arch}.tar.gz/download" -o freebasic.tar.gz
tar xf freebasic.tar.gz --strip-components=1
rm freebasic.tar.gz