#!/usr/bin/env bash
source /arch-detect.sh
arch=$(uname -m | sed 's/x86_64/x86_64/; s/aarch64/aarch64/')

# curl racket 8.3 linux installation shell file
curl -L "https://download.racket-lang.org/installers/8.3/racket-8.3-${arch}-linux-cs.sh" -o racket.sh

# provide settings "no" "4" and "<CR>" to racket.sh
echo "no
4
" | sh racket.sh

