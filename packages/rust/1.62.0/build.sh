#!/usr/bin/env bash
source /arch-detect.sh
architecture=$(get_arch_long)
curl -OL "https://static.rust-lang.org/dist/rust-1.62.0-${architecture}.tar.gz"
tar xzvf rust-1.62.0-${architecture}.tar.gz
rm rust-1.62.0-${architecture}.tar.gz
