docker run -it --rm --name certbot \
	-v "$(pwd)/certbot/etc/letsencrypt:/etc/letsencrypt" \
	-v "$(pwd)/certbot/var/lib/letsencrypt:/var/lib/letsencrypt" \
	certbot/certbot:arm32v6-latest renew

