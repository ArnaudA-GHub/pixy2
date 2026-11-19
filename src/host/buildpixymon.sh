#!/bin/bash

set -x

unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'     
else
   platform='mac'
fi

echo Building for $platform

cd src/host/pixymon

if [[ "$platform" == 'linux' ]]; then
   # Use Qt6 installation at /opt/Qt/6.12.0/gcc_64 for Qt6 compatibility
   /opt/Qt/6.12.0/gcc_64/bin/qmake pixymon.pro
   make -w
   cd ../../..
   cp src/host/pixymon/PixyMon .
   strip PixyMon
   cp src/host/pixymon/pixyflash.bin.hdr .

   # CLEAN UP
   rm -rdf src
   rm buildpixymon.sh
fi

if [[ "$platform" == 'mac' ]]; then
   # Use Qt6 installation at /opt/Qt/Tools/QtDesignStudio for Qt6 compatibility
   /opt/Qt/Tools/QtDesignStudio/qt6_design_studio_reduced_version/bin/qmake pixymon.pro
   make -w
   cd ../../..
   cp -rf src/host/pixymon/PixyMon.app .
   strip PixyMon.app/Contents/MacOS/PixyMon
   cp src/host/pixymon/pixyflash.bin.hdr PixyMon.app/Contents/MacOS

   # CLEAN UP
   rm -rdf src
   rm buildpixymon.sh
fi
