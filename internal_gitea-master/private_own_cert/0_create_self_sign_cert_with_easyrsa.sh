#!/bin/bash

root_domain=$1
domain=$2
mkdir -p cert
CURPATH=$(pwd)

export EASYRSA_REQ_CN=$root_domain

rm -Rf easy-rsa
git clone https://github.com/OpenVPN/easy-rsa.git
pushd easy-rsa/easyrsa3
./easyrsa init-pki
./easyrsa --batch build-ca nopass
./easyrsa build-server-full ${root_domain} nopass
./easyrsa build-server-full ${domain} nopass

cp pki/ca.crt ${CURPATH}/cert/ca.crt
cp pki/issued/${domain}.crt ${CURPATH}/cert/${domain}.crt
cp pki/private/${domain}.key ${CURPATH}/cert/${domain}.key


popd
