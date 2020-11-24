#!/bin/bash
if [[ $# -ne 1 ]]
then
	echo "Usage : $0 <externalhostname[:port]> (default 1194)";
	exit 1
fi

HOST="$(echo "${1}" | awk -F: '{print $1}')";
PORT="$(echo "${1}" | awk -F: '{print $2}')";

if [[ "${PORT}" == "" ]]
then
	PORT="1194";
fi

docker run -v $(pwd)/openvpn:/etc/openvpn --rm giggio/openvpn-arm ovpn_genconfig -u udp://${HOST}:${PORT}

docker run -v $(pwd)/openvpn:/etc/openvpn --rm -it giggio/openvpn-arm ovpn_initpki

