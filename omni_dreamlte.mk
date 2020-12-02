#
# Copyright (C) 2018 The TwrpBuilder Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/pb/config/common.mk)

# PBRP specific vars
# Because our device is arm64
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# dalvik optimization
$(call inherit-product, $(SRC_TARGET_DIR)/product/runtime_libart.mk)

PRODUCT_DEVICE := dreamlte
PRODUCT_NAME := omni_dreamlte
PRODUCT_MODEL := Galaxy S8
PRODUCT_BRAND := Samsung
PRODUCT_MANUFACTURER := Samsung
