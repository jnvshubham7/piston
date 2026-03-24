# Piston ARM64 Compatibility Updates

This document outlines all changes made to support ARM64 (aarch64) architecture in the Piston code execution engine.

## Summary

All hardcoded x86_64/amd64 architecture references have been updated to support dynamic architecture detection. The system now detects the host architecture at runtime and downloads/configures the appropriate binaries and build flags.

## Key Changes

### 1. Base Infrastructure

#### repo/Dockerfile
- **Changed**: `linux-headers-amd64` → `linux-headers`
- **Added**: `arch-detect.sh` to the Docker image
- Makes the system architecture-agnostic for base dependencies

#### repo/arch-detect.sh (NEW)
- Created centralized architecture detection script
- Provides helper functions: `get_arch()`, `get_arch_long()`, `get_go_arch()`
- Maps system architectures to tool-specific format requirements
- Sourced by all updated build scripts

### 2. Runtime Packages Updated

#### Language Runtimes
1. **Go** (1.16.2)
   - Updated to dynamically detect and download Linux binaries for amd64/arm64

2. **Rust** (1.50.0, 1.56.1, 1.62.0, 1.63.0, 1.65.0, 1.68.2)
   - Updated `build.sh`: Dynamic architecture-specific tarball download
   - Updated `environment`: Dynamic RUST_INSTALL_LOC path based on architecture
   - Updated `compile`: Dynamic stdlib path detection

3. **Deno** (1.7.5, 1.16.2, 1.32.3)
   - Updated to dynamically download x86_64-unknown-linux-gnu or aarch64-unknown-linux-gnu releases

4. **Crystal** (1.9.2)
   - Updated to download x86_64 or arm64 releases

5. **Zig** (0.7.1, 0.8.0, 0.9.1, 0.10.1)
   - All versions updated to handle x86_64/aarch64 architecture detection

6. **Haskell** (9.0.1)
   - Updated ghc download to support x86_64 and aarch64 architectures

7. **Racket** (8.3.0)
   - Updated to download x86_64 or aarch64 Linux CS distribution

#### Additional Languages Updated
- **FreeBASIC** (1.8.0, 1.9.0): Dynamic architecture detection
- **Raku** (6.100.0): x86_64 and aarch64 support
- **Emojicode** (1.0.2): Dynamic directory names in build script
- **Pascal** (3.2.0, 3.2.2): x86_64/aarch64 architecture mapping
- **LLVM IR** (12.0.1): Attempted ARM64 support (note: pre-built ARM64 binaries may not exist for all versions)
- **Forth** (0.7.3): Host/build architecture detection in ./BUILD-FROM-SCRATCH
- **NASM** (2.15.5): Architecture-aware compile script with error handling for unsupported architectures on ARM64

## Architecture Mapping

The arch-detect.sh script provides the following architecture mappings:

| System | get_arch() | get_arch_long() | get_go_arch() |
|--------|-----------|-----------------|---------------|
| x86_64 | amd64 | x86_64-unknown-linux-gnu | amd64 |
| aarch64/arm64 | arm64 | aarch64-unknown-linux-gnu | arm64 |
| armv7l | armv7 | armv7-unknown-linux-gnueabihf | armv6 |

## Deployment on ARM64 VMs

To deploy Piston on the Ubuntu 24.04 ARM64 VM (GNU/Linux 6.17.0-1007-oracle aarch64):

1. **Ensure Docker supports ARM64 builds**:
   ```bash
   docker buildx create --name arm64-builder --platform linux/arm64
   docker buildx use arm64-builder
   ```

2. **Build the Piston image**:
   ```bash
   docker buildx build --platform linux/arm64 -t piston:arm64 .
   ```

3. **Run the container**:
   ```bash
   docker run --platform linux/arm64 --privileged -p 2000:2000 piston:arm64
   ```

## Testing Recommendations

1. **Verify architecture detection**:
   ```bash
   uname -m  # Should show: aarch64
   docker run --platform linux/arm64 debian:buster-slim uname -m
   ```

2. **Test individual language packages**:
   - Build and test the container on ARM64
   - Verify native binaries are downloading correctly
   - Run sample programs for each language

3. **Build packages via ppman**:
   ```bash
   docker run --privileged -v ./build:/piston/packages -p 2000:2000 piston:arm64 bash -c "make go-1.16.2.pkg.tar.gz PLATFORM=docker-debian"
   ```

## Known Limitations

1. **NASM**: x86/x86_64 assembly programs cannot run on ARM64 systems. The compile script will exit with an error.

2. **LLVM IR**: Some older LLVM versions may not have pre-built ARM64 binaries. Version 12.0.1 specifically may need source compilation on ARM64.

3. **FreePascal/Haskell**: Older versions may not have ARM64 releases available. The build will fail with a curl error if the release doesn't exist.

4. **Architecture-Specific Languages**: Languages that are inherently x86-focused (like NASM) will require alternatives for ARM64 deployments.

## Files Modified

- `repo/Dockerfile`
- `repo/arch-detect.sh` (NEW)
- Multiple package `build.sh` files (22 files)
- Multiple package `environment` files (6 Rust versions)
- Multiple package `compile` files (7 Rust versions + NASM)

Total: ~35+ files updated for ARM64 compatibility

## Future Updates

When updating to newer package versions:
1. Always check if ARM64 binaries are available for the release
2. Update the build script to use the architecture detection pattern
3. Test on both x86_64 and ARM64 systems
4. Add fallback mechanisms for architectures without pre-built binaries

