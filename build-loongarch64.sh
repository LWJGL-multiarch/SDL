#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# sudo apt install cmake ninja-build libasound2-dev libpulse-dev libaudio-dev libfribidi-dev libjack-dev libsndio-dev 
# sudo apt install libusb-1.0-0-dev libx11-dev libxext-dev libxrandr-dev libxcursor-dev libxfixes-dev libxi-dev libxss-dev
# sudo apt install libxtst-dev libxkbcommon-dev libdrm-dev libgbm-dev libgl1-mesa-dev libgles2-mesa-dev libegl1-mesa-dev
# sudo apt install libdbus-1-dev libibus-1.0-dev libudev-dev libthai-dev libpipewire-0.3-dev libwayland-dev libdecor-0-dev

cmake -B build \
    -G Ninja \
    -DCMAKE_C_FLAGS="-std=c99 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=0" \
    -DSDL_TEST_LIBRARY=OFF -DSDL_TESTS=OFF -DSDL_EXAMPLES=OFF -DDSDL_DISABLE_INSTALL=ON -DCMAKE_BUILD_TYPE=Release
cmake --build build --parallel
strip ./build/libSDL3.so

# Copy result to output directory
LWJGL_OUTPUT_DIR="${LWJGL_OUTPUT_DIR:-/tmp/lwjgl3-build/output}"

mkdir -p "$LWJGL_OUTPUT_DIR"
cp ./build/libSDL3.so "$LWJGL_OUTPUT_DIR/libSDL3.so"

