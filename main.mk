ifndef OKCAR_OS_BUILD_TYPE
    OKCAR_OS_BUILD_TYPE := dev
endif

include okcar/version.mk

ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.okcaros.build.type=$(OKCAR_OS_BUILD_TYPE) \
    ro.okcaros.build.id=$(BUILD_ID) \
    ro.okcaros.build.device=$(LINEAGE_BUILD) \
    ro.okcaros.build.incremental=$(BUILD_ID) \
    ro.okcaros.build.version=1.0 \
    ro.okcaros.display.version=$(OKCAR_OS_DISPLAY_VERSION)

$(info "ADDITIONAL_SYSTEM_PROPERTIES:$(ADDITIONAL_SYSTEM_PROPERTIES)")
