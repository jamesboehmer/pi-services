#!/bin/bash
if [[ $# -ne 1 ]]
then
	echo "Usage : $0 <clientname>";
	exit 1
fi

docker run -v $(pwd)/openvpn:/etc/openvpn --rm -it giggio/openvpn-arm easyrsa build-client-full $1

docker run -v $(pwd)/openvpn:/etc/openvpn --rm giggio/openvpn-arm ovpn_getclient $1 > $1.ovpn



