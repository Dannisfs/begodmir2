LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_STATIC_JAVA_LIBRARIES := fmodjar
include $(BUILD_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := fmod
LOCAL_SRC_FILES := $(LOCAL_PATH)/../../../fmod/api/lib/$(TARGET_ARCH_ABI)/libfmod.so
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../../fmod/api/inc
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := fmodL
LOCAL_SRC_FILES := $(LOCAL_PATH)/../../../fmod/api/lib/$(TARGET_ARCH_ABI)/libfmodL.so
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../../fmod/api/inc
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES := fmodjar:libs/fmod.jar
include $(BUILD_MULTI_PREBUILT)

include $(CLEAR_VARS)
$(call import-add-path,$(LOCAL_PATH)/../../cocos2d)
$(call import-add-path,$(LOCAL_PATH)/../../cocos2d/external)
$(call import-add-path,$(LOCAL_PATH)/../../cocos2d/cocos)

LOCAL_MODULE := youme_voice_engine
LOCAL_SRC_FILES := $(LOCAL_PATH)/../../../youme_voice_engine/lib/android/$(TARGET_ARCH_ABI)/libyoume_voice_engine.so
include $(PREBUILT_SHARED_LIBRARY)

cmd-strip = $(TOOLCHAIN_PREFIX)strip --strip-debug -x $1
LOCAL_CFLAGS   += -fvisibility=hidden
LOCAL_CPPFLAGS += -fvisibility=hidden

LOCAL_MODULE := cocos2dcpp_shared

LOCAL_MODULE_FILENAME := libcocos2dcpp

FILE_LIST := hellocpp/main.cpp \
			../../Classes/AppDelegate.cpp \
			../../Classes/QuickSDKAndroid.cpp \
            ../../Classes/YouMeVoiceEngineImp.cpp \
            ../../Classes/QuickSDK.cpp
  
FILE_LIST += $(wildcard $(LOCAL_PATH)/../../Classes/*/*.cpp)  

LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%) 


LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../Classes \
$(LOCAL_PATH)/../../cocos2d/libiconv/include \
$(LOCAL_PATH)/../../cocos2d/libiconv/libcharset \
$(LOCAL_PATH)/../../cocos2d/libiconv/lib \
$(LOCAL_PATH)/../../cocos2d/libiconv/libcharset/include \
$(LOCAL_PATH)/../../cocos2d/libiconv/srclib \
$(LOCAL_PATH)/../../cocos2d/libiconv \
$(LOCAL_PATH)/../../Classes \
$(LOCAL_PATH)/../../youme_voice_engine/include

# _COCOS_HEADER_ANDROID_BEGIN
# _COCOS_HEADER_ANDROID_END


LOCAL_STATIC_LIBRARIES := cc_static
LOCAL_STATIC_LIBRARIES += libiconv_static
LOCAL_SHARED_LIBRARIES := fmodL
LOCAL_SHARED_LIBRARIES += fmod
LOCAL_SHARED_LIBRARIES += youme_voice_engine

# _COCOS_LIB_ANDROID_BEGIN
# _COCOS_LIB_ANDROID_END

include $(BUILD_SHARED_LIBRARY)

$(call import-module,.)
$(call import-module,libiconv)

# _COCOS_LIB_IMPORT_ANDROID_BEGIN
# _COCOS_LIB_IMPORT_ANDROID_END
