#!/bin/bash

set -ev

apt-get update && apt-get install -y nsis wget unzip perl

TOR_URI=https://dist.torproject.org/torbrowser/10.0.15

FILE_32=tor-win32-${TOR_PROXY_VERSION}.zip
SHA256_32=0f3a038dc1a422c4824c57933889ea7624e4cdd05b3715fc8b310d90110dd567

FILE_64=tor-win64-${TOR_PROXY_VERSION}.zip
SHA256_64=e437c6303054d238324507321ed8a4a9a2e67da523f537c5cab9aa1a84344a66

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
