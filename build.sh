#!/bin/bash

set -ev

apt-get update && apt-get install -y nsis wget tar gzip perl

TOR_EXPERT_BUNDLE_VERSION=13.0.8

TOR_URI=https://dist.torproject.org/torbrowser/${TOR_EXPERT_BUNDLE_VERSION}

FILE_32=tor-expert-bundle-windows-i686-${TOR_EXPERT_BUNDLE_VERSION}.tar.gz
SHA256_32=f4ba15c89b95c9c6cc088b2c11c268a2a2353f26ac9fb7b59837110209fbab76

FILE_64=tor-expert-bundle-windows-x86_64-${TOR_EXPERT_BUNDLE_VERSION}.tar.gz
SHA256_64=4d304f915c11b7e168342043d9db3cdbf157747be0bc42d67ea0b91ef9ec492f

wget ${TOR_URI}/${FILE_32}
echo "$SHA256_32  $FILE_32" > $FILE_32.sha256
shasum -a256 -s -c $FILE_32.sha256

wget ${TOR_URI}/${FILE_64}
echo "$SHA256_64  $FILE_64" > $FILE_64.sha256
shasum -a256 -s -c $FILE_64.sha256

mkdir Tor
tar xf tor-expert-bundle-windows-i686-*.tar.gz -C Tor && rm tor-expert-bundle-windows-i686-*.tar.gz tor-expert-bundle-windows-i686-*.tar.gz.sha256
makensis -DTOR_PROXY_VERSION=$TOR_PROXY_VERSION tor-proxy32.nsi
rm -rf Tor && mkdir -p dist && mv *.exe dist/

mkdir Tor
tar xf tor-expert-bundle-windows-x86_64-*.tar.gz -C Tor && rm tor-expert-bundle-windows-x86_64-*.tar.gz tor-expert-bundle-windows-x86_64-*.tar.gz.sha256
makensis -DTOR_PROXY_VERSION=$TOR_PROXY_VERSION tor-proxy64.nsi
rm -rf Tor && mkdir -p dist && mv *.exe dist/
