# Engine

A basic cross-platform (Mac, Windows, Linux, HTML5, Android) 3D game engine making use of:

- SDL2 window library.
- stb_image.h image library.
- OpenGL 3 / OpenGL ES 2.0 / OpenGL ES 3.0 Graphics APIs.
- Assimp asset importing library.
- GLEW extension loading library.

## Usage

#### Mac Build
```
brew install sdl2 assimp glew glm cmake
```

After create the make file or project with cmake:

```
./cmake-make.sh
```

Then if in Mac or Linux:
```
cd bin
make -j8
```

#### HTML 5 WebGL engine Build
To build the html5 engine:

First install emscripten:
```
brew install emscripten
```

then compile assimp with emscripten:
```
git clone git@github.com:assimp/assimp.git
cd assimp
mkdir build.em
cd build.em
export EMSCRIPTEN_PATH=/usr/local/opt/emscripten/libexec # or wherever emscripten is installed

cmake -DEMSCRIPTEN=1 -DCMAKE_TOOLCHAIN_FILE=$EMSCRIPTEN_PATH/cmake/Modules/Platform/Emscripten.cmake -DASSIMP_BUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=$EMSCRIPTEN_PATH/Modules/cmake  ..

# OR to compile assimp with less importers do this:

cmake -DEMSCRIPTEN=1 -DCMAKE_TOOLCHAIN_FILE=$EMSCRIPTEN_PATH/cmake/Modules/Platform/Emscripten.cmake -DASSIMP_BUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Release  -DCMAKE_MODULE_PATH=$EMSCRIPTEN_PATH/Modules/cmake -DASSIMP_BUILD_3DS_IMPORTER=FALSE -DASSIMP_BUILD_AC_IMPORTER=FALSE -DASSIMP_BUILD_ASE_IMPORTER=FALSE -DASSIMP_BUILD_ASSBIN_IMPORTER=FALSE -DASSIMP_BUILD_ASSXML_IMPORTER=FALSE -DASSIMP_BUILD_B3D_IMPORTER=FALSE -DASSIMP_BUILD_BVH_IMPORTER=FALSE -DASSIMP_BUILD_COLLADA_IMPORTER=FALSE -DASSIMP_BUILD_PLY_IMPORTER=FALSE -DASSIMP_BUILD_MS3D_IMPORTER=FALSE -DASSIMP_BUILD_COB_IMPORTER=FALSE -DASSIMP_BUILD_BLEND_IMPORTER=FALSE -DASSIMP_BUILD_IFC_IMPORTER=FALSE -DASSIMP_BUILD_XGL_IMPORTER=FALSE -DASSIMP_BUILD_FBX_IMPORTER=FALSE -DASSIMP_BUILD_Q3D_IMPORTER=FALSE -DASSIMP_BUILD_Q3BSP_IMPORTER=FALSE -DASSIMP_BUILD_RAW_IMPORTER=FALSE -DASSIMP_BUILD_SMD_IMPORTER=FALSE -DASSIMP_BUILD_STL_IMPORTER=FALSE -DASSIMP_BUILD_TERRAGEN_IMPORTER=FALSE -DASSIMP_BUILD_3D_IMPORTER=FALSE -DASSIMP_BUILD_X_IMPORTER=FALSE -DASSIMP_BUILD_OFF_IMPORTER=FALSE -DASSIMP_BUILD_OGRE_IMPORTER=FALSE -DASSIMP_BUILD_OPENGEX_IMPORTER=FALSE ..

# then run:
make -j8
make install
```

Then build the engine:
```
./cmake-emscripten.sh

cd bin-emscripten
make -j8

python -m SimpleHTTPServer

open http://localhost:8000/game.html
```

#### Android Build

To build for android do the following:

First download the android ndk and sdk (https://developer.android.com/tools/sdk/ndk/) and (https://developer.android.com/sdk/index.html)
Then download the android ndk cmake toolchain (android.toolchain.cmake) from (https://code.google.com/p/android-cmake/)

```
export NDK_PATH=/path/to/your/android/ndk/

cd $NDK_PATH/build/tools

./make-standalone-toolchain.sh --platform=android-8 --install-dir=$HOME/android-toolchain --ndk-dir=$NDK_PATH –-toolchain=arm-linux-androideabi-4.4.3 --system=darwin-x86_64

export ANDROID_NDK_TOOLCHAIN=$HOME/android-toolchain

export ANDTOOLCHAIN=/path/to/android.toolchain.cmake

export PATH=$PATH:$HOME/path/to/android-sdk/tools

# compile assimp with android toolchain:

git clone git@github.com:assimp/assimp.git
cd assimp
mkdir build.android
cd build.android
cmake -DCMAKE_TOOLCHAIN_FILE=$ANDTOOLCHAIN -DCMAKE_INSTALL_PREFIX=/assimp-2.0 -DANDROID_ABI=armeabi-v7a _DANDROID_NATIVE_API_LEVEL=android-8 -DANDROID_FORCE_ARM_BUILD=TRUE ..

vim code/cMakeFiles/assimp.dir/link.txt
# search for the string "-soname, libassimp.so.3" and replace with "-soname, libassimp.so"

make

cd ../lib

# look for libassimp.so.some_version_number and rename it to libassimp.so

cp libassimp.so /path/to/engine/android/jni/src/libassimp.so

# Now add sdl src

cd /path/to/engine/android/jni/
# Download SDL source to this folder

# setup for android is now done!

cd /path/to/engine/android/

# build src for android with
ndk-build -j8

# create apk with
ant debug

# connect device and install apk with
adb install -r bin/SDLActivity-debug.apk

# view logs from device with
adb logcat | grep EngineLogger
```

### To Use:

To use the engine in a game build the engine library and include Engine.h in your game.

Eg:

```c++
#include "Engine.h"

class CoolGame : public Game
{
public:
  virtual void init(void);

private:
  Entity *test_entity;
};

void CoolGame::init(void)
{
  test_entity = new Entity();
  test_entity->addComponent(new MeshRenderer(new Mesh("../assets/monkey3.obj"), new Texture("../assets/t.jpg")));
  addToScene(test_entity);
}

int main(int argc, char **argv){
  CoolGame game;
  Engine gm(&game);

  gm.start();

  return 0;
}
```

## Contributing

1. Fork it ( http://github.com/Shervanator/Engine/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
