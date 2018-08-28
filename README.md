# Build OpenSSL For Android

This document describes how to build the binary openssl libraries for Android platform.
It is based on https://wiki.openssl.org/index.php/Android. In my setup, the build machine
is running in a VirtualBox with Ubuntu-14.04.04. It also works in the Docker Ubuntu 14.04
container.

1. Download Android NDK(e.g. android-ndk-r12b-linux-x86_64.zip) from android.com and save
it into your home folder.

2. Download openssl source code(e.g. openssl-1.1.0h.tar.gz)from openssl.org and save it
into your home folder.

3. From the home folder, execute
```
	unzip android-ndk-r12b-linux-x86_64.zip
	tar xzf openssl-1.1.0h.tar.gz
```
4. Copy build-all.sh and build-android.sh into openssl-1.1.0h folder.

5. From the home folder, execute
```
	cd openssl-1.1.0h
	chmod a+x build-*.sh
	./build-all.sh
```
6. Copy folder ~/openssl-1.1.0h/prebuilts/lib from the linux box to your Android project.

You are done!
