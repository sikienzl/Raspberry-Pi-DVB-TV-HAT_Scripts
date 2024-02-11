#!/bin/bash

# Author: Siegfried Kienzle
# Email: sikienzl.github at t-online.de
# Date: 2024-02-11
# Version: 1.0
# License: MIT
# Description: This script is used to download
# the format script 
# Usage: bash download_format_script.sh

FILELINK="https://github.com/sikienzl/embedded-linux-quick-start-files/archive/refs/heads/master.zip"
FILENAME="embedded-linux-quick-start-files-master.zip"
EXTRACTEDFOLDER="embedded-linux-quick-start-files-master"
UTILSFOLDER="./utils/"
FORMATSCRIPT="format-sdcard.sh"

# Test if the file exists
if [ -f $FILENAME ]; then
    echo "================================="
    echo "| File $FILENAME already exists |"
    echo "================================="
    echo -en "\n"
    read -p "Do you want to remove it? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm $FILENAME
        echo -en "\n"
    else
        echo "====================================="
        echo "| The script will now be terminated |"
        echo "====================================="
        exit 1
    fi
fi

# Test if $UTILSFOLDER exists
if [ -d $UTILSFOLDER ]; then
    echo "=================================="
    echo "| Folder $UTILSFOLDER already exists |"
    echo "=================================="
    echo -en "\n"
    read -p "Do you want to remove it? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf $UTILSFOLDER
        echo -en "\n"
    else
        echo "====================================="
        echo "| The script will now be terminated |"
        echo "====================================="
        exit 1
    fi
fi

# Test if the link is reachable
if ! wget -q --spider --no-check-certificate $FILELINK; then
    echo "========================="
    echo "| Link is not reachable |"
    echo "========================="
    exit 1
fi

echo "=============================================================="
echo "| Start to download the utility files                        |"
echo "| and save it as $FILENAME |"
echo "=============================================================="
wget -O $FILENAME $FILELINK -q --show-progress --no-check-certificate

echo -en "\n"
echo "===================================================="
echo "| Start to extract the $FORMATSCRIPT script     |"
echo "| from $FILENAME |"
echo "===================================================="
unzip -q $FILENAME
rm -rf $FILENAME

echo -en "\n"
echo "================================================"
echo "| Move the $FORMATSCRIPT script to $UTILSFOLDER |"
echo "================================================"
mkdir $UTILSFOLDER
mv $EXTRACTEDFOLDER/$FORMATSCRIPT $UTILSFOLDER
rm -rf $EXTRACTEDFOLDER
