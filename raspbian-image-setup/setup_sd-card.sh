#!/bin/bash

# Author: Siegfried Kienzle
# Email: sikienzl.github at t-online.de
# Date: 2024-02-11
# Version: 1.0
# License: MIT
# Description: This script is used to download the Raspbian Buster image
# and check the integrity of the image and the check sum.
# Usage: bash setup_sd-card.sh <sd-card-device>

SDCARDDEVICEFILE=$1
SDCARDDEVICE=""
IMAGE="2021-05-07-raspios-buster-arm64-lite.img"
ZIPFILE="2021-05-07-raspios-buster-arm64-lite.zip"

# check if the sd card device is given
if [ -z $SDCARDDEVICEFILE ]; then
    echo "=================================="
    echo "| No SD card device is given     |"
    echo "=================================="
    exit 1
else 
    SDCARDDEVICE=$(basename $SDCARDDEVICEFILE)
fi

# Download first all necessary files
sh download_format_script.sh

# check if the image exists
if [ ! -f $IMAGE ]; then
    sh download_buster.sh
fi

# check if util folder exists
if [ ! -d ./utils ]; then
    echo "=================================="
    echo "| Folder ./utils does not exist |"
    echo "=================================="
    exit 1
fi

# check if format-sdcard.sh exists
if [ ! -f ./utils/format-sdcard.sh ]; then
    echo "================================================"
    echo "| File ./utils/format-sdcard.sh does not exist |"
    echo "================================================"
    exit 1
fi

#unzip the image
if [ -f $ZIPFILE ]; then
    unzip $ZIPFILE
    rm -f $ZIPFILE
fi

# check if the image exists
if [ ! -f $IMAGE ]; then
    echo "==============================="
    echo "| File $IMAGE does not exist |"
    echo "==============================="
    exit 1
fi

# format and write the image to the sd card
sh ./format_write_sd-card.sh "$SDCARDDEVICE" "$IMAGE"

echo "===================================="
echo "| The setup of the SD card is done |"
echo "| Please remove the SD card and    |"
echo "| insert it into the Raspberry Pi  |"
echo "===================================="
