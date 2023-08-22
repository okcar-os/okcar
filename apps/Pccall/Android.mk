LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := src/main.c

LOCAL_MODULE := pccall
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/system/bin
LOCAL_MODULE_TAGS := optional

LOCAL_SHARED_LIBRARIES := liblog

include $(BUILD_EXECUTABLE)

# test
# make pccall && adb push out/target/product/dipper/system/bin/pccall /data/local/tmp/ && adb shell /data/local/tmp/pccall -m 1