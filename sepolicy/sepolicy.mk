#$(error "=============TARGET_BOARD_PLATFORM:$(TARGET_BOARD_PLATFORM)")
ifneq (,$(filter sdm845 sdm710 msm8998, $(TARGET_BOARD_PLATFORM)))
    BOARD_VENDOR_SEPOLICY_DIRS += \
        okcar/sepolicy/vendor_sysfs_usb
endif

ifneq (,$(filter universal9820, $(TARGET_BOARD_PLATFORM)))
    BOARD_VENDOR_SEPOLICY_DIRS += \
        okcar/sepolicy/vendor_sysfs_usb \
        okcar/sepolicy/universal9820
endif

ifneq (,$(filter mt6771, $(TARGET_BOARD_PLATFORM)))
    BOARD_VENDOR_SEPOLICY_DIRS += \
        okcar/sepolicy/vendor_sysfs_usb
endif

BOARD_VENDOR_SEPOLICY_DIRS += \
    okcar/sepolicy/okcar

#$(error "BOARD_VENDOR_SEPOLICY_DIRS:$(BOARD_VENDOR_SEPOLICY_DIRS) SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS:$(SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS)")
