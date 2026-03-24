#!/usr/bin/env bash
source /arch-detect.sh
arch=$(uname -m | sed 's/x86_64/x86_64/; s/aarch64/aarch64/')
# Note: LLVM may not have pre-built binaries for all architectures/versions
# If ARM64 builds aren't available, this may need to build from source
curl -L "https://github.com/llvm/llvm-project/releases/download/llvmorg-12.0.1/clang+llvm-12.0.1-${arch}-linux-gnu-ubuntu-16.04.tar.xz" -o llvm-ir.tar.xz

tar xf llvm-ir.tar.xz clang+llvm-12.0.1-${arch}-linux-gnu-ubuntu-/bin --strip-components=1

rm llvm-ir.tar.xz
