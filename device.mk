$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/fairphone/fp2/fp2-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/fairphone/fp2/overlay

# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Audio configuration file
PRODUCT_COPY_FILES += \
    device/fairphone/fp2/audio/audio_policy.conf:system/etc/audio_policy.conf \
    device/fairphone/fp2/audio/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    device/fairphone/fp2/audio/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/fairphone/fp2/audio/mixer_paths_auxpcm.xml:system/etc/mixer_paths_auxpcm.xml

# media_profiles and media_codecs xmls for 8974
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/fairphone/fp2/media/media_profiles_8974.xml:system/etc/media_profiles.xml \
                      device/fairphone/fp2/media/media_codecs_8974.xml:system/etc/media_codecs.xml
endif #TARGET_ENABLE_QC_AV_ENHANCEMENTS

PRODUCT_PACKAGES += \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libqcompostprocbundle

# Feature definition files for 8974
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml

# Battery_monitor
PRODUCT_PACKAGES += \
    battery_monitor \
    battery_shutdown

# Ramdisk configurations
PRODUCT_COPY_FILES += \
    device/fairphone/fp2/rootdir/fstab.qcom:root/fstab.qcom \
    device/fairphone/fp2/rootdir/ueventd.qcom.rc:root/ueventd.qcom.rc \
    device/fairphone/fp2/rootdir/init.qcom.rc:root/init.qcom.rc \
    device/fairphone/fp2/rootdir/init.recovery.usb.rc:root/init.recovery.usb.rc

# WiFi WCNSS configurations
PRODUCT_COPY_FILES += \
    device/fairphone/fp2/wlan/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/fairphone/fp2/wlan/WCNSS_qcom_wlan_nv.bin:persist/WCNSS_qcom_wlan_nv.bin

# WPA supplicant configurations
PRODUCT_COPY_FILES += \
    device/fairphone/fp2/wlan/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
    device/fairphone/fp2/wlan/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf

PRODUCT_PACKAGES += wcnss_service

# ANT stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    ANTRadioService \
    antradio_app

# Display
PRODUCT_PACKAGES += \
    copybit.msm8974 \
    gralloc.msm8974 \
    hwcomposer.msm8974 \
    memtrack.msm8974

# Keystore
PRODUCT_PACKAGES += \
    keystore.msm8974

# Audio
PRODUCT_PACKAGES += \
    audiod \
    audio.a2dp.default \
    audio_policy.msm8974 \
    audio.primary.msm8974 \
    audio.r_submix.default \
    audio.usb.default

PRODUCT_PACKAGES += \
    libaudio-resampler \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    tinymix

# Power
PRODUCT_PACKAGES += \
    power.msm8974

# OMX
PRODUCT_PACKAGES += \
    libOmxCore \
    libOmxVdec \
    libOmxVenc \
    libstagefrighthw

# Camera
PRODUCT_PACKAGES += \
    camera.msm8974 \

# Enable strict operation
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.strict_op_enable=false # \
#    persist.sys.usb.config=mtp

# Camera
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    camera2.portability.force_api=1

# AppOps
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.whitelist=/system/etc/whitelist_appops.xml

PRODUCT_COPY_FILES += \
    device/fairphone/fp2/appops/whitelist_appops.xml:system/etc/whitelist_appops.xml

# Media (OpenMAX)
PRODUCT_BOOT_JARS += \
    qcmediaplayer

# Fonts
EXTENDED_FONT_FOOTPRINT := true

# QCOM Performance
PRODUCT_BOOT_JARS += \
    org.codeaurora.Performance

# Misc
PRODUCT_BOOT_JARS += \
    vcard \
    tcmiface

# QCOM boot
ifneq ($(strip $(QCPATH)),)
PRODUCT_BOOT_JARS += WfdCommon # Wifi display
PRODUCT_BOOT_JARS += qcom.fmradio #  FM Radio
PRODUCT_BOOT_JARS += security-bridge
PRODUCT_BOOT_JARS += qsb-port
PRODUCT_BOOT_JARS += oem-services # QCOM services
endif


$(call inherit-product, build/target/product/full.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Set adb.secure to 0
PRODUCT_PROPERTY_OVERRIDES += \
    ro.adb.secure=0

PRODUCT_NAME := full_fp2
PRODUCT_DEVICE := fp2
