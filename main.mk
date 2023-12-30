ifndef OKCAR_OS_BUILD_TYPE
    OKCAR_OS_BUILD_TYPE := dev
endif

OK_PRODUCT_VERSION_MAJOR = 1
OK_PRODUCT_VERSION_MINOR = 0

ifeq ($(OKCAR_OS_VERSION_APPEND_TIME_OF_DAY),true)
    OKCAR_OS_BUILD_DATE := $(shell date -u +%Y%m%d_%H%M%S)
else
    OKCAR_OS_BUILD_DATE := $(shell date -u +%Y%m%d)
endif

OKCAR_OS_VERSION_SUFFIX := $(OKCAR_OS_BUILD_DATE)-$(OKCAR_OS_BUILD_TYPE)-$(BUILD_ID)

# Display version
OKCAR_OS_DISPLAY_VERSION := $(OK_PRODUCT_VERSION_MAJOR).${OK_PRODUCT_VERSION_MINOR}-$(OKCAR_OS_VERSION_SUFFIX)


ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.okcaros.build.type=$(OKCAR_OS_BUILD_TYPE) \
    ro.okcaros.build.id=$(BUILD_ID) \
    ro.okcaros.build.device=$(LINEAGE_BUILD) \
    ro.okcaros.build.incremental=$(BUILD_ID) \
    ro.okcaros.build.version=1.0 \

ADDITIONAL_VENDOR_PROPERTIES += \
    ro.surface_flinger.supports_background_blur=1 \
    ro.sf.blurs_are_expensive=1

#    persist.dbg.keep_debugfs_mounted=1

# Promoter ID: Promoters can earn certain profits when users make purchases.
# For more details, please visit: https://u.okcar.com."
# ADDITIONAL_SYSTEM_PROPERTIES += \
#     ro.okcaros.promoter.id=223366


# $(info "ADDITIONAL_SYSTEM_PROPERTIES:$(ADDITIONAL_SYSTEM_PROPERTIES)")
# $(info "BOARD_VENDOR_SEPOLICY_DIRS:$(BOARD_VENDOR_SEPOLICY_DIRS)")
# $(info "PRODUCT_PACKAGES:$(PRODUCT_PACKAGES)")
