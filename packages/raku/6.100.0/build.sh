#!/usr/bin/env bash
source /arch-detect.sh
arch=$(uname -m | sed 's/x86_64/x86_64/; s/aarch64/aarch64/')

curl -L "https://rakudo.org/dl/rakudo/rakudo-moar-2021.05-01-linux-${arch}-gcc.tar.gz" -o raku.tar.xz
tar xf raku.tar.xz --strip-components=1
rm raku.tar.xz