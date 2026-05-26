#!/bin/bash

echo "🔍 Detecting USB device from Windows..."
BUSID=$(powershell.exe -Command "usbipd list | Select-String 'CP210' | ForEach-Object { \$_.ToString().Split()[0] }" | tr -d '\r')

if [ -z "$BUSID" ]; then
    echo "❌ No CP210x device found in Windows. Plug it in and try again."
    exit 1
fi

echo "📌 Found device at BUSID: $BUSID"

echo "🔗 Binding device..."
powershell.exe -Command "usbipd bind --busid $BUSID" >/dev/null 2>&1

echo "🔗 Attaching device to WSL..."
powershell.exe -Command "usbipd attach --wsl --busid $BUSID" >/dev/null 2>&1

echo "⏳ Waiting for /dev/ttyUSB0..."
sleep 1

if [ ! -e /dev/ttyUSB0 ]; then
    echo "❌ /dev/ttyUSB0 not found. Something went wrong."
    exit 1
fi

echo "🚀 Uploading firmware..."
pio run -e nodemcuv2 -t upload --upload-port /dev/ttyUSB0
