set -e

export GIT_SUBMODULE_STRATEGY=recursive
export ANDROID_PLATFORM=android-23
# export ICU_BUILD_VERSION=74.2
# export ICU_BUILD_HASH=68db082212a96d6f53e35d60f47d38b962e9f9d207a74cfac78029ae8ff5e08c
# export ANDROID_NDK=~/sdks/android/ndk/26.2.11394342
export ICU_BUILD_VERSION=77.1
export ICU_BUILD_HASH=588e431f77327c39031ffbb8843c0e3bc122c211374485fa87dc5f3faff24061
# for page size alignment
export ANDROID_NDK=~/sdks/android/ndk/28.2.13676358

rm -rf build-android-arm64-v8a
cmake -B build-android-arm64-v8a -DCMAKE_BUILD_TYPE=Release -DBUILD_ICU=ON -DICU_BUILD_VERSION=$ICU_BUILD_VERSION -DICU_BUILD_HASH=$ICU_BUILD_HASH -DANDROID_PLATFORM=$ANDROID_PLATFORM -DANDROID_ABI=arm64-v8a -DANDROID_TOOLCHAIN=clang -DANDROID_NDK=$ANDROID_NDK -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake
cmake --build build-android-arm64-v8a --config Release

rm -rf build-android-armeabi-v7a
cmake -B build-android-armeabi-v7a -DCMAKE_BUILD_TYPE=Release -DBUILD_ICU=ON -DICU_BUILD_VERSION=$ICU_BUILD_VERSION -DICU_BUILD_HASH=$ICU_BUILD_HASH -DANDROID_PLATFORM=$ANDROID_PLATFORM -DANDROID_ABI=armeabi-v7a -DANDROID_TOOLCHAIN=clang -DANDROID_NDK=$ANDROID_NDK -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake
cmake --build build-android-armeabi-v7a --config Release

rm -rf build-android-i686
cmake -B build-android-i686 -DCMAKE_BUILD_TYPE=Release -DBUILD_ICU=ON -DICU_BUILD_VERSION=$ICU_BUILD_VERSION -DICU_BUILD_HASH=$ICU_BUILD_HASH -DANDROID_PLATFORM=$ANDROID_PLATFORM -DANDROID_ABI=x86 -DANDROID_TOOLCHAIN=clang -DANDROID_NDK=$ANDROID_NDK -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake
cmake --build build-android-i686 --config Release

rm -rf build-android-x86_64
cmake -B build-android-x86_64 -DCMAKE_BUILD_TYPE=Release -DBUILD_ICU=ON -DICU_BUILD_VERSION=$ICU_BUILD_VERSION -DICU_BUILD_HASH=$ICU_BUILD_HASH -DANDROID_PLATFORM=$ANDROID_PLATFORM -DANDROID_ABI=x86_64 -DANDROID_TOOLCHAIN=clang -DANDROID_NDK=$ANDROID_NDK -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake
cmake --build build-android-x86_64 --config Release

# copy to ndk
cp -a build-android-x86_64/icu_cross/include/.  ${ANDROID_NDK}/toolchains/llvm/prebuilt/darwin-x86_64/sysroot/usr/include/

cp -a build-android-armeabi-v7a/icu_cross/lib/. ${ANDROID_NDK}/toolchains/llvm/prebuilt/darwin-x86_64/sysroot/usr/lib/arm-linux-androideabi/
cp -a build-android-i686/icu_cross/lib/.        ${ANDROID_NDK}/toolchains/llvm/prebuilt/darwin-x86_64/sysroot/usr/lib/i686-linux-android/
cp -a build-android-arm64-v8a/icu_cross/lib/.   ${ANDROID_NDK}/toolchains/llvm/prebuilt/darwin-x86_64/sysroot/usr/lib/aarch64-linux-android/
cp -a build-android-x86_64/icu_cross/lib/.      ${ANDROID_NDK}/toolchains/llvm/prebuilt/darwin-x86_64/sysroot/usr/lib/x86_64-linux-android/
