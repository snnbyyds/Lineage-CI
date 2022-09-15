#!/bin/bash

# Source Configs

export USE_CCACHE=1
export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL="C"
##########################

# A Function to Send Posts to Telegram
telegram_message() {
	curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
	-d chat_id="${TG_CHAT_ID}" \
	-d parse_mode="HTML" \
	-d text="$1"
}

# Change to the Source Directry
cd ~/android


# Set-up ccache
ccache -M 60G

###################### fix?#####################

#echo '[DEBUG]rm -rf  system/sepolicy/prebuilts/api/33.0/private/property.te'
#rm -rf  system/sepolicy/prebuilts/api/33.0/private/property.te
#echo '[DEBUG]cp -r system/sepolicy/private/property.te system/sepolicy/prebuilts/api/33.0/private/'
#cp -r system/sepolicy/private/property.te system/sepolicy/prebuilts/api/33.0/private/
#ls system/sepolicy/prebuilts/api/33.0/private/
#################################################


# Prepare the Build Environment
cd ~/android
source build/envsetup.sh

echo "extracting proprietary"
mkdir ~/android/system_dump/
cd ~/android/system_dump/
pwd
#git clone https://github.com/Evolution-X-Devices/vendor_oneplus.git ~/vendor_oneplus
git clone -b cust https://github.com/snnbyyds/vendor_oneplus.git ~/vendor_oneplus
mkdir system/
mkdir system/vendor/
mkdir system/odm/
mkdir system/product/
mkdir system/system_ext/
cp -r ~/vendor_oneplus/sdm845-common/proprietary/system .
cp -r ~/vendor_oneplus/sdm845-common/proprietary/system_ext system/
cp -r ~/vendor_oneplus/sdm845-common/proprietary/vendor system/
cp -r ~/vendor_oneplus/sdm845-common/proprietary/product system/
cp -r ~/vendor_oneplus/fajita/proprietary/odm system/
cp -r ~/vendor_oneplus/fajita/proprietary/vendor system/
cd ~/android/device/oneplus/fajita
./extract-files.sh ~/android/system_dump/


cd ~/android
breakfast fajita

# Build!
echo 'Start Build!'
croot
brunch fajita -j16

# Exit
exit 0
