#!/bin/sh

if [[ "${LETS_ENCRYPT_CERT}" == "" ]]
then
	echo "LETS_ENCRYPT_CERT MUST BE DEFINED" && exit 1;
fi

set -e;

echo "Symlinking /cert to /etc/letsencrypt/live/${LETS_ENCRYPT_CERT} /cert ...";

ln -sf /etc/letsencrypt/live/${LETS_ENCRYPT_CERT} /cert;

