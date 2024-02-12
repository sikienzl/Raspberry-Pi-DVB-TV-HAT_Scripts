#!/bin/bash

# Author: Siegfried Kienzle
# Email: sikienzl.github at t-online.de
# Date: 2024-02-11
# Version: 1.0
# License: MIT
# Description: This script is used to download the Raspbian Buster image
# and check the integrity of the image and the check sum.
# Usage: bash setup_sd-card.sh <sd-card-device> <image>

SDCARDDEVICE=$1
IMAGE=$2

echo "=============================="
echo "| Start to setup the SD card |"
echo "=============================="
# Format the SD card
sh ./utils/format-sdcard.sh $SDCARDDEVICE

# Write the image to the SD card
dd if=$IMAGE of=$SDCARDDEVICE bs=4M status=progress conv=fsync