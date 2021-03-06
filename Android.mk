LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
        $(call all-logtags-files-under, src)

LOCAL_MODULE := settings-logtags

include $(BUILD_STATIC_JAVA_LIBRARY)

# Build the Settings APK
include $(CLEAR_VARS)

LOCAL_PACKAGE_NAME := Settings
LOCAL_CERTIFICATE := platform
LOCAL_PRIVILEGED_MODULE := true
LOCAL_MODULE_TAGS := optional
LOCAL_USE_AAPT2 := true

LOCAL_SRC_FILES := $(call all-java-files-under, src) \
                   $(call all-java-files-under, ../DotExtras/src) \
		   $(call all-java-files-under, ../DotUICenter/src)

LOCAL_RESOURCE_DIR := $(LOCAL_PATH)/res \
    frameworks/support/v7/preference/res \
    frameworks/support/v14/preference/res \
    frameworks/support/v7/appcompat/res \
    frameworks/support/v7/recyclerview/res \
    frameworks/support/design/res \
    packages/apps/DotExtras/res \
    packages/apps/DotUICenter/res

LOCAL_STATIC_ANDROID_LIBRARIES := \
    android-support-v4 \
    android-support-v13 \
    android-support-v7-appcompat \
    android-support-v7-cardview \
    android-support-v7-preference \
    android-support-v7-recyclerview \
    android-support-v14-preference \
    android-support-design 

LOCAL_JAVA_LIBRARIES := \
    bouncycastle \
    core-oj \
    telephony-common \
    ims-common \
	telephony-ext \
    org.dirtyunicorns.utils \
    org.apache.http.legacy

LOCAL_STATIC_JAVA_LIBRARIES := \
    android-support-v4 \
    android-support-v7-appcompat \
    android-support-v7-preference \
    android-support-v7-recyclerview \
    android-support-v14-preference \
    jsr305 \
    libsuperuser \
    settings-logtags \
    okhttpcustom \
    okio \
    retrofit \
    converter-gson \
    rxjava \
    adapter-rxjava \
    gson \
    reactive-streams

LOCAL_STATIC_JAVA_AAR_LIBRARIES += \
    rxandroid

LOCAL_PROGUARD_FLAG_FILES := proguard.flags

LOCAL_FULL_LIBS_MANIFEST_FILES := $(LOCAL_PATH)/AndroidManifest-UI.xml

LOCAL_AAPT_FLAGS := --auto-add-overlay \
    --extra-packages android.support.v7.preference \
    --extra-packages android.support.v14.preference \
    --extra-packages android.support.v17.preference \
    --extra-packages android.support.v7.appcompat \
    --extra-packages android.support.v7.recyclerview \
    --extra-packages android.support.design \
    --extra-packages com.dot.dotextras \
    --extra-packages com.dot.uicenter \
    --extra-packages io.reactivex.android

ifneq ($(INCREMENTAL_BUILDS),)
    LOCAL_PROGUARD_ENABLED := disabled
    LOCAL_JACK_ENABLED := incremental
    LOCAL_JACK_FLAGS := --multi-dex native
endif

include frameworks/opt/setupwizard/library/common-gingerbread.mk
include frameworks/base/packages/SettingsLib/common.mk

include $(BUILD_PACKAGE)

include $(CLEAR_VARS)

LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES := \
	libsuperuser:lib/libsuperuser.jar \
    okhttpcustom:libs/okhttp-3.8.1.jar \
    okio:libs/okio-1.13.0.jar \
    retrofit:libs/retrofit-2.4.0.jar \
    converter-gson:libs/converter-gson-2.4.0.jar \
    rxjava:libs/rxjava-2.1.11.jar \
    adapter-rxjava:libs/adapter-rxjava2-2.4.0.jar \
    rxandroid:libs/rxandroid-2.0.2.aar \
    gson:libs/gson-2.8.2.jar \
    reactive-streams:libs/reactive-streams-1.0.2.jar

include $(BUILD_MULTI_PREBUILT)

# Use the following include to make our test apk.
ifeq (,$(ONE_SHOT_MAKEFILE))
include $(call all-makefiles-under,$(LOCAL_PATH))
endif
