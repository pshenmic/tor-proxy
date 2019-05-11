#!/bin/bash

apt-get update && apt-get install -y nsis wget unzip

wget https://dist.torproject.org/torbrowser/8.0.9/tor-win32-0.3.5.8.zip
unzip -d Tor tor-win32-*.zip && rm tor-win32-*.zip
makensis -DTOR_PROXY_VERSION=$TOR_PROXY_VERSION tor-proxy.nsi
rm -rf Tor && mkdir dist && mv *.exe dist/
