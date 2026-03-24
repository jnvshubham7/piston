#!/bin/bash
source /arch-detect.sh
architecture=$(get_arch_long)
curl -OL "https://github.com/denoland/deno/releases/download/v1.32.3/deno-${architecture}.zip"
unzip -o deno-${architecture}.zip
rm deno-${architecture}.zip