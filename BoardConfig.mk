#
# Copyright (C) 2015-2016 The CyanogenMod Project
#           (C) 2017-2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/lenovo/kingdom

# Assert compatibility
TARGET_OTA_ASSERT_DEVICE := kingdom,kingdom_row,kingdomt

# Include path
TARGET_SPECIFIC_HEADER_PATH += $(DEVICE_PATH)/include

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8974
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Platform
TARGET_BOARD_PLATFORM := msm8974
TARGET_BOARD_PLATFORM_GPU := qcom-adreno330

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := krait
TARGET_CPU_SMP := true
ARCH_ARM_HAVE_TLS_REGISTER := true

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_IMAGE_NAME := zImage
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_CMDLINE := console=tty60,115200,n8 androidboot.hardware=qcom \
                        user_debug=31 msm_rtb.filter=0x3b7 androidboot.bootdevice=msm_sdcc.1 \
			ehci-hcd.park=3 \
			vmalloc=480M \
			pm.sleep_mode=1 \
			androidboot.selinux=permissive

BOARD_KERNEL_SEPARATED_DT := true
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x02000000 --tags_offset 0x01e00000
BOARD_DTBTOOL_ARGS := -2
TARGET_KERNEL_ARCH := arm
TARGET_KERNEL_SOURCE := kernel/cyanogen/msm8974
TARGET_KERNEL_CONFIG := lineageos_k920_defconfig

# ANT+
BOARD_ANT_WIRELESS_DEVICE := "vfs-prerelease"

# Audio
AUDIO_FEATURE_ENABLED_EXTN_FORMATS := true
AUDIO_FEATURE_ENABLED_EXTN_POST_PROC := true
AUDIO_FEATURE_ENABLED_FLUENCE := true
AUDIO_FEATURE_ENABLED_HFP := true
AUDIO_FEATURE_ENABLED_HWDEP_CAL := true
AUDIO_FEATURE_ENABLED_LOW_LATENCY_CAPTURE := true
AUDIO_FEATURE_ENABLED_MULTI_VOICE_SESSIONS := true
AUDIO_FEATURE_ENABLED_NEW_SAMPLE_RATE := true
AUDIO_FEATURE_ENABLED_PROXY_DEVICE := true
AUDIO_FEATURE_LOW_LATENCY_PRIMARY := true
BOARD_USES_ALSA_AUDIO := true
USE_XML_AUDIO_POLICY_CONF := 1
USE_CUSTOM_AUDIO_POLICY := 1

# Binder
TARGET_USES_64_BIT_BINDER := true

# Bionic
TARGET_LD_SHIM_LIBS := \
    /system/vendor/bin/mpdecision|libshims_atomic.so \
    /system/vendor/lib/libqomx_jpegenc.so|libboringssl-compat.so \
    /system/vendor/lib/libmmqjpeg_codec.so|libboringssl-compat.so

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
QCOM_BT_USE_SMD_TTY := true
BLUETOOTH_HCI_USE_MCT := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth
BOARD_CUSTOM_BT_CONFIG := $(DEVICE_PATH)/bluetooth/vnd_kingdom.txt

# Boot animation
TARGET_BOOTANIMATION_HALF_RES := true
TARGET_BOOTANIMATION_MULTITHREAD_DECODE := true
TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true

# Camera
# TARGET_USE_VENDOR_CAMERA_EXT := true
USE_DEVICE_SPECIFIC_CAMERA := true
TARGET_NEEDS_LEGACY_CAMERA_HAL1_DYN_NATIVE_HANDLE := true
TARGET_PROCESS_SDK_VERSION_OVERRIDE += \
    /system/bin/mediaserver=22 \
    /system/vendor/bin/mm-qcamera-daemon=22

# Charger
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_CHARGER_DISABLE_INIT_BLANK := true
BACKLIGHT_PATH := "/sys/class/leds/lcd-backlight/brightness"
RED_LED_PATH := "/sys/class/leds/led:rgb_red/brightness"
GREEN_LED_PATH := "/sys/class/leds/led:rgb_green/brightness"
BLUE_LED_PATH := "/sys/class/leds/led:rgb_blue/brightness"
BLINK_PATH := "/sys/class/leds/led:rgb_red/blink"

# Display
TARGET_MSM8974_1440P_EGL_WORKAROUND := true

# Lineage Hardware
JAVA_SOURCE_OVERLAYS := org.lineageos.hardware|$(DEVICE_PATH)/lineagehw|**/*.java

# Tap to wake
TARGET_TAP_TO_WAKE_NODE := "/sys/class/touchscreen/device/gesture"

# Encryption
TARGET_HW_DISK_ENCRYPTION := true
TARGET_CRYPTFS_HW_PATH := vendor/qcom/opensource/cryptfs_hw
TARGET_LEGACY_HW_DISK_ENCRYPTION := true

# Extended filesystem support
TARGET_EXFAT_DRIVER := sdfat

# Filesystem
BOARD_FLASH_BLOCK_SIZE                  := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE          := 20971520
BOARD_RECOVERYIMAGE_PARTITION_SIZE      := 20971520
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE       := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE         := 419430400   # preload partition size
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE     := ext4
BOARD_PERSISTIMAGE_PARTITION_SIZE       := 33554432
BOARD_SYSTEMIMAGE_PARTITION_SIZE        := 2147483648
BOARD_USERDATAIMAGE_PARTITION_SIZE      := 28097608704 # 28097625088 - 16384
BOARD_OEMIMAGE_FILE_SYSTEM_TYPE         := ext4
BOARD_OEMIMAGE_PARTITION_SIZE           := 134217728
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE      := ext4
BOARD_VENDORIMAGE_PARTITION_SIZE        := 134217728   # cache partition size

TARGET_COPY_OUT_VENDOR := vendor

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

TARGET_FS_CONFIG_GEN := $(DEVICE_PATH)/config.fs
BOARD_ROOT_EXTRA_FOLDERS := firmware

# Use mke2fs instead of make_ext4fs
TARGET_USES_MKE2FS := true

# FM
BOARD_HAVE_QCOM_FM := true
TARGET_QCOM_NO_FM_FIRMWARE := true

# GPS
BOARD_VENDOR_QCOM_LOC_PDK_FEATURE_SET := true
USE_DEVICE_SPECIFIC_LOC_API := true
USE_DEVICE_SPECIFIC_GPS := true

# GPS HAL
TARGET_GPS_HAL_PATH := $(DEVICE_PATH)/gps
TARGET_PROVIDES_GPS_LOC_API := true

# Graphics
USE_OPENGL_RENDERER := true
TARGET_CONTINUOUS_SPLASH_ENABLED := true
TARGET_USES_ION := true
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS := 0x02000000U
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so
HAVE_ADRENO_SOURCE:= false
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
TARGET_NEEDS_PLATFORM_TEXT_RELOCATIONS := true

# Shader cache config options
# Maximum size of the  GLES Shaders that can be cached for reuse.
# Increase the size if shaders of size greater than 12KB are used.
MAX_EGL_CACHE_KEY_SIZE := 12*1024

# Maximum GLES shader cache size for each app to store the compiled shader
# binaries. Decrease the size if RAM or Flash Storage size is a limitation
# of the device.
MAX_EGL_CACHE_SIZE := 2048*1024

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

# HWUI
HWUI_COMPILE_FOR_PERF := true

# Init
TARGET_INIT_VENDOR_LIB := libinit_kingdom
TARGET_RECOVERY_DEVICE_MODULES := libinit_kingdom

# Keymaster
TARGET_KEYMASTER_WAIT_FOR_QSEE := true

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# Media
TARGET_USES_MEDIA_EXTENSIONS := true

# NFC
#BOARD_NFC_CHIPSET := pn547
#BOARD_NFC_DEVICE := /dev/pn547
#BOARD_NFC_HAL_SUFFIX := $(TARGET_BOARD_PLATFORM)

# Power
TARGET_HAS_LEGACY_POWER_STATS := true
TARGET_HAS_NO_WLAN_STATS := true
TARGET_USES_INTERACTION_BOOST := true

# QCOM hardware
BOARD_USES_QCOM_HARDWARE := true

# Radio
TARGET_RIL_VARIANT := caf

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom

# SELinux
include device/qcom/sepolicy-legacy/sepolicy.mk

BOARD_SEPOLICY_DIRS += \
    $(DEVICE_PATH)/sepolicy

# Snapdragon LLVM
TARGET_USE_SDCLANG := true

# Wifi
BOARD_HAS_QCOM_WLAN              := true
BOARD_WLAN_DEVICE                := qcwcn
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_qcwcn
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_qcwcn
PRODUCT_VENDOR_MOVE_ENABLED      := true
WIFI_DRIVER_FW_PATH_STA          := "sta"
WIFI_DRIVER_FW_PATH_AP           := "ap"
TARGET_USES_QCOM_WCNSS_QMI       := true
TARGET_USES_WCNSS_MAC_ADDR_REV   := true

# Media
TARGET_USES_MEDIA_EXTENSIONS := true

# Added to indicate that protobuf-c is supported in this build
PROTOBUF_SUPPORTED := true

-include vendor/lenovo/kingdom/BoardConfigVendor.mk
