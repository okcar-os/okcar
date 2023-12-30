PRODUCT_PACKAGES += \
    pccall \
    autoconn \
    oklauncher \
    okappstore \
    minusscreen \
    OkcarFrameworksResTarget \
    OkcarSettingsProviderResTarget \
    OkcarSystemUIResTarget


PRODUCT_COPY_FILES += \
    okcar/init/init.okcar.rc:vendor/etc/init/hw/init.okcar.rc \
    okcar/init/init.exynos9820.okcar.rc:vendor/etc/init/hw/init.exynos9820.okcar.rc \
    okcar/init/init.qcom.okcar.rc:vendor/etc/init/hw/init.qcom.okcar.rc \
    okcar/init/okcar.hidreport.bin:vendor/etc/init/hw/okcar.hidreport.bin \
    okcar/init/ueventd.okcar.rc:vendor/etc/init/hw/ueventd.okcar.rc

PRODUCT_EXTRA_RECOVERY_KEYS += \
    okcar/build/target/product/security/recovery/okcarprod \
    okcar/build/target/product/security/ota/okcardev

# okcardev is PUBLIC KEY
PRODUCT_EXTRA_OTA_KEYS += \
    okcar/build/target/product/security/ota/okcardev \
    okcar/build/target/product/security/recovery/okcarprod
