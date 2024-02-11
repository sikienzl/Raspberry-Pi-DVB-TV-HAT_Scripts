#!/bin/bash
IMAGELINK="https://downloads.raspberrypi.org/raspbian/images/raspbian-2020-02-14/2020-02-13-raspbian-buster.zip"
CHECKSUM="https://downloads.raspberrypi.org/raspbian/images/raspbian-2020-02-14/2020-02-13-raspbian-buster.zip.sha256"
FILENAME="2020-02-13-raspbian-buster.zip"
CHECKSUMFILE="2020-02-13-raspbian-buster.zip.sha256"

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
if ! wget -q --spider --no-check-certificate $IMAGELINK; then
    echo "========================="
    echo "| Link is not reachable |"
    echo "========================="
    exit 1
fi


echo "======================================================================="
echo "| Start to download the check sum for the                             |"
echo "| Raspbian Buster image and save it as $FILENAME |"
echo "======================================================================="

wget $CHECKSUM -q --show-progress --no-check-certificate

echo -en "\n"
echo "================================================="
echo "| Start to download the Raspbian Buster image   |"
echo "| and save it as $FILENAME |"
echo "================================================="
wget -O $FILENAME $IMAGELINK -q --show-progress --no-check-certificate

echo -en "\n"
echo "==============================================="
echo "| Start to check the integrity of the image    |"
echo "| and the check sum                            |"
echo "==============================================="
expected_checksum=$(cat $CHECKSUMFILE | awk '{print $1}')
actual_checksum=$(sha256sum $FILENAME | awk '{print $1}')
if [ "$expected_checksum" != "$actual_checksum" ]; then
    echo "====================================="
    echo "| The check sum is not correct      |"
    echo "====================================="
else
    echo "====================================="
    echo "| The check sum is correct          |"
    echo "====================================="
fi

# clean up check sum file
rm $CHECKSUMFILE
