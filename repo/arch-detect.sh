#!/usr/bin/env bash
# Architecture detection helper for piston packages

get_arch() {
    local machine=$(uname -m)
    case "$machine" in
        x86_64)
            echo "amd64"
            ;;
        aarch64|arm64)
            echo "arm64"
            ;;
        armv7l)
            echo "armv7"
            ;;
        armv6l)
            echo "armv6"
            ;;
        *)
            echo "unsupported"
            return 1
            ;;
    esac
}

get_arch_long() {
    local machine=$(uname -m)
    case "$machine" in
        x86_64)
            echo "x86_64-unknown-linux-gnu"
            ;;
        aarch64|arm64)
            echo "aarch64-unknown-linux-gnu"
            ;;
        armv7l)
            echo "armv7-unknown-linux-gnueabihf"
            ;;
        *)
            echo "unsupported"
            return 1
            ;;
    esac
}

get_go_arch() {
    local machine=$(uname -m)
    case "$machine" in
        x86_64)
            echo "amd64"
            ;;
        aarch64|arm64)
            echo "arm64"
            ;;
        armv7l)
            echo "armv6"
            ;;
        *)
            echo "unsupported"
            return 1
            ;;
    esac
}

export -f get_arch get_arch_long get_go_arch
