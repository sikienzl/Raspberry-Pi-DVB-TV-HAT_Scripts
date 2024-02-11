#!/bin/bash

# Author: Siegfried Kienzle
# Email: sikienzl.github at t-online.de
# Date: 2024-02-11
# Version: 1.0
# License: MIT
# Description: This script is used to get the DE sender list for DVB-T2
# from picockpit.com and save it to a file.
# Usage: bash get_DE_DVB-T2_senderlist.sh 

FILENAME="de-DVBT2"
LINK="https://picockpit.com/raspberry-pi/wp-content/uploads/2022/10/aa-All.txt"

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

# Test if the link is reachable
if ! wget -q --spider --no-check-certificate $LINK; then
    echo "========================="
    echo "| Link is not reachable |"
    echo "========================="
    exit 1
fi

echo "==============================================="
echo "| Start to download DE sender list for DVB-T2 |"
echo "| from picockpit.com and save it as $FILENAME  |"
echo "==============================================="

# This script is used to get the DE sender list for DVB-T2
# from picockpit.com and save it to a file.
wget -O $FILENAME $LINK -q --show-progress --no-check-certificate

