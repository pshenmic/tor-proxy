#!/bin/bash

apt-get update && apt-get install -y nsis wget unzip

wget https://www.torproject.org/dist/torbrowser/7.5.6/tor-win32-0.3.3.7.zip
unzip -d Tor tor-win32-*.zip && rm tor-win32-*.zip
makensis tor-proxy.nsi
rm -rf Tor && mkdir dist && mv *.exe dist/
