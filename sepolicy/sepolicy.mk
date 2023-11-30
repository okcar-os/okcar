#$(error "=============TARGET_BOARD_PLATFORM:$(TARGET_BOARD_PLATFORM)")
ifneq (,$(filter sdm845 sdm710 msm8998, $(TARGET_BOARD_PLATFORM)))
    BOARD_VENDOR_SEPOLICY_DIRS += \
        okcar/sepolicy/sdm845
endif

ifneq (,$(filter universal9820, $(TARGET_BOARD_PLATFORM)))
    BOARD_VENDOR_SEPOLICY_DIRS += \
        okcar/sepolicy/samsung_exynos9820
endif

BOARD_VENDOR_SEPOLICY_DIRS += \
    okcar/sepolicy/okcar

#$(error "BOARD_VENDOR_SEPOLICY_DIRS:$(BOARD_VENDOR_SEPOLICY_DIRS) SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS:$(SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS)")
