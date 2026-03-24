#!/bin/bash
source /arch-detect.sh
arch=$(uname -m | sed 's/x86_64/x86_64/; s/aarch64/aarch64/')

PREFIX=$(realpath $(dirname $0))

mkdir -p build

cd build

# Platform specific because a true source compile would require GHC to be installed already on the latest
curl -L "https://downloads.haskell.org/~ghc/9.0.1/ghc-9.0.1-${arch}-deb10-linux.tar.xz" -o ghc.tar.xz
tar xf ghc.tar.xz --strip-components=1
rm ghc.tar.xz

./configure --prefix="$PREFIX"
make install -j$(nproc)

cd ../

rm -rf build
