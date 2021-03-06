#!/bin/bash

set -e
if [ -r nc/root/include/atlas/atlas_client.h ]; then
  echo Already installed
  cp nc/root/lib/libatlas* build/Release
  exit 0
fi

if [ $# = 0 ] ; then
  echo "Usage: $0 <version>" >&2
  exit 1
fi

rm -rf nc
mkdir nc
cd nc
git init 
git remote add origin https://github.com/Netflix-Skunkworks/atlas-native-client.git
git fetch origin $NATIVE_CLIENT_VERSION
git reset --hard FETCH_HEAD
mkdir build root
cd build
cmake -DCMAKE_INSTALL_PREFIX=/ -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo ..
make -j2
make install DESTDIR=../root
cp ../root/lib/libatlas* ../../build/Release
