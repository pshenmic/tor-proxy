#!/bin/bash

set -ev

apt-get update && apt-get install -y nsis wget unzip

TOR_URI=https://dist.torproject.org/torbrowser/9.0.6

FILE_32=tor-win32-${TOR_PROXY_VERSION}.zip
SHA256_32=b3ccfdbf11f0eb63d26c95a7178c0583e4fde54cd9f46159edbc868856b9e6ae

FILE_64=tor-win64-${TOR_PROXY_VERSION}.zip
SHA256_64=75a350e686a700e89f2247629a561378ab4cf7633fe524486f94635791af6b60

wget ${TOR_URI}/${FILE_32}
echo "$SHA256_32  $FILE_32" > $FILE_32.sha256
shasum -a256 -s -c $FILE_32.sha256

wget ${TOR_URI}/${FILE_64}
echo "$SHA256_64  $FILE_64" > $FILE_64.sha256
shasum -a256 -s -c $FILE_64.sha256

unzip -d Tor tor-win32-*.zip && rm tor-win32-*.zip tor-win32-*.zip.sha256
makensis -DTOR_PROXY_VERSION=$TOR_PROXY_VERSION tor-proxy32.nsi
rm -rf Tor && mkdir -p dist && mv *.exe dist/

unzip -d Tor tor-win64-*.zip && rm tor-win64-*.zip tor-win64-*.zip.sha256
makensis -DTOR_PROXY_VERSION=$TOR_PROXY_VERSION tor-proxy64.nsi
rm -rf Tor && mkdir -p dist && mv *.exe dist/
