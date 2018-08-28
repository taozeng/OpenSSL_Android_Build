#!/bin/bash

ARCH=$1
ANDROID_API=$2
NDK_PATH=$3
BUILD_PLATFORM="linux-x86_64"

if [ "$ARCH" = "arm" ]; then
	TOOL_NAME=arm-linux-androideabi
	SYSROOT=$NDK_PATH/platforms/${ANDROID_API}/arch-arm
	ANDROID_ARCH=armeabi
	CROSS=arm-linux-androideabi
	OS_COMPILER=android-armeabi
elif [ "$ARCH" = "armv7a" ]; then
	TOOL_NAME=arm-linux-androideabi
	SYSROOT=$NDK_PATH/platforms/${ANDROID_API}/arch-arm
	EXFLAGS="-march=armv7-a"
	ANDROID_ARCH=armeabi-v7a
	CROSS=arm-linux-androideabi
	OS_COMPILER=android-armeabi
elif [ "$ARCH" = "arm64" ]; then
	TOOL_NAME=aarch64-linux-android
	SYSROOT=$NDK_PATH/platforms/${ANDROID_API}/arch-arm64
	ANDROID_ARCH=arm64-v8a
	CROSS=aarch64-linux-android
	OS_COMPILER=android64-aarch64
elif [ "$ARCH" = "x86" ]; then
	TOOL_NAME=x86
	SYSROOT=$NDK_PATH/platforms/${ANDROID_API}/arch-x86
	ANDROID_ARCH=x86
	CROSS=i686-linux-android
	OS_COMPILER=android-x86
elif [ "$ARCH" = "x86_64" ]; then
	TOOL_NAME=x86_64
	SYSROOT=$NDK_PATH/platforms/${ANDROID_API}/arch-x86_64
	ANDROID_ARCH=x86_64
	CROSS=x86_64-linux-android
	OS_COMPILER=android64
else
	echo "Invalid input (only support arm, armv7a, arm64, x86 and x86_64)"
	exit
fi

# Set TOOLCHAIN
TOOLCHAIN=$NDK_PATH/toolchains/${TOOL_NAME}-4.9/prebuilt/${BUILD_PLATFORM}/bin/${CROSS}

# Android NDK
export NDK_PATH

# Android Platform
export SYSROOT

# Android_tools
export CC=${TOOLCHAIN}-gcc
export CXX=${TOOLCHAIN}-g++
export LD=${TOOLCHAIN}-ld
export STRIP=${TOOLCHAIN}-strip
export AR=${TOOLCHAIN}-ar
export NM=${TOOLCHAIN}-nm
export RANLIB=${TOOLCHAIN}-ranlib
export CFLAGS="${CFLAGS} ${EXFLAGS}"

env

# Configure
./Configure $OS_COMPILER shared no-ssl2 no-ssl3 no-comp no-hw no-engine --sysroot=${SYSROOT} --prefix=$(pwd)/build/$ANDROID_API/$ANDROID_ARCH $CFLAGS

# Clean
make clean

# Depend
make depend

# Build
make all

# Install
make install

