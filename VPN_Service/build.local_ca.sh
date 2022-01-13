#!/bin/bash
rm -Rf tools
mkdir -p tools 
pushd tools
wget https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.6/EasyRSA-unix-v3.0.6.tgz
tar xvf EasyRSA-unix-v3.0.6.tgz
rm -f EasyRSA-unix-v3.0.6.tgz
popd
cp vars tools/EasyRSA-v3.0.6/

ROOT_DOMAIN=boar.com
VPN_SERVER_DOMAIN=vpn.boar.com

pushd tools/EasyRSA-v3.0.6/
./easyrsa init-pki
./easyrsa --batch build-ca nopass
#./easyrsa build-server-full ${ROOT_DOMAIN} nopass
#./easyrsa build-server-full ${VPN_SERVER_DOMAIN} nopass

popd
