#!/bin/bash
#
mkdir ~/bin
PATH=~/bin:$PATH

# Change to the Home Directory
cd ~

# repo!
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

# FUCK BIGFOOTACA
rm -rf ~/android
mkdir ~/android
cd ~/android

# A Function to Send Posts to Telegram
telegram_message() {
	curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
	-d chat_id="${TG_CHAT_ID}" \
	-d parse_mode="HTML" \
	-d text="$1"
}

# Clone the Sync Repo
cd ~/android
repo init -u https://github.com/LineageOS/android.git -b lineage-20.0


# Sync the Sources
cd ~/android
echo '[DEBUG]repo sync -j6'
repo sync -j6

cd ~/android && pwd

# Clone Device Specific(fallback)
rm -rf device/oneplus/fajita
git clone -b lineage-20 https://github.com/LineageOS/android_device_oneplus_fajita.git device/oneplus/fajita
ls device/oneplus/fajita
rm -rf device/oneplus/sdm845-common
git clone -b lineage-20 https://github.com/LineageOS/android_device_oneplus_sdm845-common.git device/oneplus/sdm845-common
ls device/oneplus/sdm845-common

# Clone the Kernel Sources(fallback)
git clone --depth=1 -b lineage-20.0 https://github.com/EdwinMoq/android_kernel_oneplus_sdm845.git kernel/oneplus/sdm845
#git clone -b ElementalX-6.00 https://github.com/flar2/OnePlus6.git kernel/oneplus/sdm845
#git clone https://github.com/CherishOS-Devices/kernel_oneplus_sdm845.git kernel/oneplus/sdm845
#git clone -b oos11 https://github.com/ppajda/android_kernel_oneplus_sdm845.git kernel/oneplus/sdm845
#git clone -b 12.1 https://github.com/snnbyyds/platform_kernel_oneplus_sdm845.git kernel/oneplus/sdm845
#git clone -b nethunter-11.0 https://github.com/snnbyyds/nethunter_kernel_oneplus_sdm845-3.git kernel/oneplus/sdm845
#git clone -b snow https://github.com/Evolution-X-Devices/kernel_oneplus_sdm845.git kernel/oneplus/sdm845
#git clone -b lineage-19.1 https://github.com/snnbyyds/android_kernel_oneplus_sdm845.git ~/android_kernel_oneplus_sdm845
#git clone -b oneplus/SDM845_R_11.0 https://github.com/snnbyyds/android_kernel_oneplus_sdm845-1.git kernel/oneplus/sdm845
#git clone -b oneplus/SDM845_R_11.0 https://github.com/OnePlusOSS/android_kernel_oneplus_sdm845_techpack_audio.git kernel/oneplus/sdm845/techpack/audio

# Additional(fallback)

git clone -b lineage-20 https://github.com/LineageOS/android_hardware_oneplus.git hardware/oneplus

# Exit
exit 0
