#!/bin/bash
if [[ $# -ne 1 ]]
then 
	echo "Usage : $0 <wildcardcert> (e.g. '*.domain.com')";
	exit 1
fi

docker run -it --rm --name certbot \
	-v "$(pwd)/certbot/etc/letsencrypt:/etc/letsencrypt" \
	-v "$(pwd)/certbot/var/lib/letsencrypt:/var/lib/letsencrypt" \
	certbot/certbot:arm32v6-latest --manual --preferred-challenge dns certonly -d $1


