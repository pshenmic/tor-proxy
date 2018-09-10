#!/bin/bash

apt-get update && apt-get install -y nsis wget unzip

wget https://www.torproject.org/dist/torbrowser/8.0/tor-win32-0.3.3.9.zip
unzip -d Tor tor-win32-*.zip && rm tor-win32-*.zip
makensis -DTOR_PROXY_VERSION=$TOR_PROXY_VERSION tor-proxy.nsi
rm -rf Tor && mkdir dist && mv *.exe dist/
