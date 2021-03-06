LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := assimp
LOCAL_SRC_FILES := libassimp.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := main

LOCAL_CFLAGS := -DGLES3

SDL_PATH := ../SDL

# TODO: FIX ABSOLUTE PATHS
LOCAL_C_INCLUDES := $(LOCAL_PATH)/$(SDL_PATH)/include \
  /usr/local/Cellar/glm/0.9.5.4/include \
  /Users/shervinaflatooni/Git/assimp/include

# Add your application source files here...
LOCAL_SRC_FILES := $(SDL_PATH)/src/main/android/SDL_android_main.c \
  engsrc/EntityComponent.cpp \
  engsrc/DebugComponent.cpp \
  engsrc/Transform.cpp \
  engsrc/MeshRenderer.cpp \
  engsrc/Game.cpp \
  engsrc/Camera.cpp \
  engsrc/FreeMove.cpp \
  engsrc/FreeLook.cpp \
  engsrc/GLEWManager.cpp \
  engsrc/GLManager.cpp \
  engsrc/Engine.cpp \
  engsrc/Input.cpp \
  engsrc/Mesh.cpp \
  engsrc/MeshLoader.cpp \
  engsrc/Box.cpp \
  engsrc/Plane.cpp \
  engsrc/Window.cpp \
  engsrc/Entity.cpp \
  engsrc/Shader.cpp \
  engsrc/Texture.cpp \
  engsrc/BaseLight.cpp \
  engsrc/DirectionalLight.cpp \
  engsrc/PointLight.cpp \
  engsrc/SpotLight.cpp \
  engsrc/Material.cpp \
  engsrc/Asset.cpp \
  engsrc/Attenuation.cpp \
  engsrc/CustomIOStream.cpp \
  engsrc/CustomIOSystem.cpp \
  engsrc/AndroidAssetManager.cpp \
  engsrc/Main.cpp

LOCAL_SHARED_LIBRARIES := SDL2 assimp

LOCAL_LDLIBS := -lGLESv1_CM -lGLESv3 -llog -landroid

LOCAL_CPP_FEATURES += exceptions
LOCAL_CFLAGS += -std=c++11

include $(BUILD_SHARED_LIBRARY)
