#!/usr/bin/env bash
source /arch-detect.sh
architecture=$(get_go_arch)
curl -LO https://golang.org/dl/go1.16.2.linux-${architecture}.tar.gz
tar -xzf go1.16.2.linux-${architecture}.tar.gz
rm go1.16.2.linux-${architecture}.tar.gz

