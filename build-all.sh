#/bin/bash

# build all platforms into build/
api='android-23'
ndk="../android-ndk-r12b"
for arch in "arm" "armv7a" "arm64" "x86" "x86_64"; do
	echo ""
	echo "### building OpenSSL for $arch ($api) with $ndk ###"
	echo ""
	./build-android.sh $arch $api $ndk
done

# copy files from build/ into prebuilts/
regex='android-\w+/(.*)/lib/'
for file in `find build -name "*.a"`; do
	if [[ $file =~ $regex ]]
	then
		archpath="prebuilts/lib/${BASH_REMATCH[1]}/"
		mkdir -p $archpath
		cp $file $archpath
	fi
done