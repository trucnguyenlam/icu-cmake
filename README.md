# ICU-CMake
CMake script supplying `ICU` libraries conveniently, encapsulating the
`ICU` build system on various platforms.

See the [CI configuration](.gitlab-ci.yml) for examples on (cross) compiling.

## Features
* Allows usage of system ICU
* Allows trivial and complex building of ICU
* Allows cross compilation, especially for Android
* Defaults to prebuilt binaries

## System ICU
To use the system ICU, simply set `SYSTEM_ICU=ON`.

## Prebuilt ICU
Default behaviour is the download of a prebuilt binary. This is only intended
as a convenience for debugging purposes and NOT for production use. 
Available prebuilt binaries can be viewed [here](https://builds.viaduck.org/prebuilts/icu/).
The prebuilt Windows binaries are built with MinGW-w64, so they may not be compatible with MSVC.

## Build ICU
In order to build `ICU`, set `BUILD_ICU=ON` along with the version, for example `ICU_BUILD_VERSION=61.1`. 
For source package integrity, an optional SHA256 `ICU_BUILD_HASH` can be supplied.

### General Cross Compile
Cross compilation is enabled using `ICU_CROSS_ARCH=<architecture triplet>` to specify the target.

### Android Cross Compile
Android requires the cross compile triplet as well as standard Android CMake toolchain configuration options.
These options are not required when using `ICU-CMake` from Gradle's native build system. 

## Usage
1. Add `ICU-CMake` as a submodule to your Git project using `git submodule 
add <URL> external/icu-cmake`
2. Initialize the submodule using `git submodule update --init --recursive`
3. In your `CMakeLists.txt` include the directory using 
`add_subdirectory(external/icu-cmake)`
4. Link against the `icu` target, which will also include the headers

## Licensing
These scripts, unless otherwise stated, are subject to the MIT license.
