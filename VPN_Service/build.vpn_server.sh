#!/bin/bash

WORKDIR=$(pwd)
OVPN_WS=${WORKDIR}/vpn_config/
RSA_TOOL_DIR=tools/EasyRSA-v3.0.6/
pushd ${RSA_TOOL_DIR}
./easyrsa --batch gen-req server nopass
echo Write server.key into ${OVPN_WS}
cp pki/private/server.key ${OVPN_WS}/vpn_server.key
popd


echo import server request file as 'vpn_server'
pushd ${RSA_TOOL_DIR}
./easyrsa import-req pki/reqs/server.req vpn_server
popd

echo With the local req, sign the req
pushd ${RSA_TOOL_DIR}
./easyrsa --batch sign-req server vpn_server
popd

echo Copy the signed certificate back to 'vpn_server'
pushd ${RSA_TOOL_DIR}
cp pki/issued/vpn_server.crt $OVPN_WS
cp pki/ca.crt $OVPN_WS
popd

echo Generate Diffie-Hellman key
pushd ${RSA_TOOL_DIR}
./easyrsa gen-dh
cp pki/dh.pem $OVPN_WS
popd

echo generate HMAC signature to strengthen the server’s TLS integrity verification capabilities

docker run -it  --rm \
    -v ${OVPN_WS}:/etc/openvpn/setup \
    vpn-server-base:debian \
    openvpn --genkey --secret /etc/openvpn/setup/ta.key
