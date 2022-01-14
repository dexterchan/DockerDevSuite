#!/bin/bash
CLIENT_NAME=$1
WORKDIR=$(pwd)
OVPN_SERVER_WS=${WORKDIR}/vpn_config/
CLIENT_ROOT_WS=${WORKDIR}/vpnclient_config/
CLIENT_CONFIG_WS=${WORKDIR}/vpnclient_config/client${CLIENT_NAME}
RSA_TOOL_DIR=tools/EasyRSA-v3.0.6/

VPN_CLIENT_NAME=vpn_client${CLIENT_NAME}

mkdir -p ${CLIENT_CONFIG_WS}

echo generate client ${CLIENT_NAME} key
pushd $RSA_TOOL_DIR
./easyrsa --batch gen-req ${VPN_CLIENT_NAME} nopass

cp pki/private/${VPN_CLIENT_NAME}.key ${CLIENT_CONFIG_WS}
popd

# echo import client request file as '${VPN_CLIENT_NAME}'
# pushd ${RSA_TOOL_DIR}
# ./easyrsa import-req pki/reqs/${VPN_CLIENT_NAME}.req ${VPN_CLIENT_NAME}
# popd


echo With the local req, sign the client req
pushd ${RSA_TOOL_DIR}
./easyrsa --batch sign-req client ${VPN_CLIENT_NAME}
popd


echo Copy the signed certificate back to 'vpn_server'
pushd ${RSA_TOOL_DIR}
cp pki/issued/${VPN_CLIENT_NAME}.crt $CLIENT_CONFIG_WS
cp pki/ca.crt $CLIENT_CONFIG_WS
cp ${OVPN_SERVER_WS}/ta.key $CLIENT_CONFIG_WS
popd