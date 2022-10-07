#
# Copyright (C) 2021 The TWRP Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Enable project quotas and casefolding for emulated storage without sdcardfs
#$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Enable virtual A/B OTA
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

LOCAL_PATH := device/nothing/spacewar

#include kernel/nothing/spacewar/Android.mk

# API
PRODUCT_SHIPPING_API_LEVEL := 31

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl \
    android.hardware.boot@1.1-service \
    android.hardware.boot@1.1-impl-wrapper.recovery \
    android.hardware.boot@1.1-impl-wrapper \
    android.hardware.boot@1.1-impl.recovery \
    bootctrl.lahaina \
    bootctrl.lahaina.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Keystore
PRODUCT_PACKAGES += \
    android.system.keystore2

# Screen
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/qcom-caf/bootctrl \
    vendor/qcom/opensource/commonsys-intf/display

# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# TWRP Configuration
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_USE_TOOLBOX := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_REPACKTOOLS := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
#TW_Y_OFFSET := 80
#TW_H_OFFSET := -80
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TARGET_USES_MKE2FS := true
TW_NO_SCREEN_BLANK := true
TW_EXCLUDE_APEX := true
TW_FRAMERATE := 90
#TW_LOAD_VENDOR_MODULES := "machine_dlkm.ko mxl5007t.ko rmnet_shs.ko tua9001.ko adsp_loader_dlkm.ko max2165.ko native_dlkm.ko rx_macro_dlkm.ko tuner-simple.ko apr_dlkm.ko mbhc_dlkm.ko pinctrl_lpi_dlkm.ko si2157.ko tuner-types.ko bolero_cdc_dlkm.ko mc44s803.ko pinctrl_wcd_dlkm.ko slimbus-ngd.ko tuner-xc2028.ko bt_fm_slim.ko platform_dlkm.ko slimbus.ko tx_macro_dlkm.ko btpower.ko q6_dlkm.ko snd_event_dlkm.ko va_macro_dlkm.ko e4000.ko q6_notifier_dlkm.ko stub_dlkm.ko wcd937x_dlkm.ko fc0011.ko q6_pdr_dlkm.ko swr_ctrl_dlkm.ko wcd937x_slave_dlkm.ko fc0012.ko qcom_edac.ko swr_dlkm.ko wcd938x_dlkm.ko fc0013.ko msi001.ko qm1d1b0004.ko swr_dmic_dlkm.ko wcd938x_slave_dlkm.ko fc2580.ko msm_drm.ko qm1d1c0042.ko swr_haptics_dlkm.ko wcd9xxx_dlkm.ko fts_tp.ko mt2060.ko qt1010.ko tda18212.ko wcd_core_dlkm.ko goodix_fp.ko mt2063.ko r820t.ko tda18218.ko wsa883x_dlkm.ko hdmi_dlkm.ko mt20xx.ko radio-i2c-rtc6226-qca.ko tda18250.ko wsa_macro_dlkm.ko hid-aksys.ko mt2131.ko rdbg.ko tda9887.ko xc4000.ko it913x.ko mt2266.ko rmnet_core.ko tea5761.ko xc5000.ko llcc_perfmon.ko mxl301rf.ko rmnet_ctl.ko tea5767.ko m88rs6000t.ko mxl5005s.ko rmnet_offload.ko tfa98xx_dlkm.ko"
TW_OVERRIDE_SYSTEM_PROPS := \
    "ro.build.date.utc;ro.build.product;ro.build.fingerprint=ro.system.build.fingerprint;ro.build.version.incremental;ro.product.device=ro.product.system.device;ro.product.model=ro.product.system.model;ro.product.name=ro.product.system.name"

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
BOARD_USES_QCOM_FBE_DECRYPTION := true

#Properties
TW_OVERRIDE_SYSTEM_PROPS := \
    "ro.build.fingerprint=ro.system.build.fingerprint;ro.build.version.incremental"

TARGET_RECOVERY_DEVICE_MODULES += \
    libdisplayconfig.qti \
    libion \
    vendor.display.config@1.0 \
    vendor.display.config@2.0

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so

PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# VINTF
PRODUCT_ENFORCE_VINTF_MANIFEST := true