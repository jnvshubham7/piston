#!/usr/bin/env bash
source /arch-detect.sh
arch=$(uname -m | sed 's/x86_64/x86_64/; s/aarch64/aarch64/')

curl -L "https://github.com/emojicode/emojicode/releases/download/v1.0-beta.2/Emojicode-1.0-beta.2-Linux-${arch}.tar.gz" -o emoji.tar.gz
tar xzf emoji.tar.gz

mv "Emojicode-1.0-beta.2-Linux-${arch}" emoji

rm emoji.tar.gz

cd emoji

./install.sh


chmod +x emojicodec

cd ..
