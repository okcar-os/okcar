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