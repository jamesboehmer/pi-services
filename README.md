# pi-services

This project is a collection of docker containers that I run on my raspberry pi.  Set a handful of configs in .env and run `docker-compose up` to start everything.  Expose external ports 60888/tcp for Bitwarden, and 1194/udp for OpenVPN.

## Setup

1. Run `git submodule init && git submodule update`
2. Run `certbot-create.sh` to create letsencrypt certs
3. Run `nginx-create-dhparams.sh` to create a new dhparams.pem 
4. Edit `ddclient/config/ddclient.conf.example` and save as `ddclient/config/ddclient.conf`
5. Run `openvpn-init.sh` to initialize the openvpn server
6. Edit `openvpn/openvpn.conf` and configure DNS and routes, e.g.:

	```
	push dhcp-option DNS 192.168.4.44
	push route 192.168.0.0 255.255.0.0
	```

7. Add the following to `.env`:

	```
	ADMIN_TOKEN=<bitwardenadminpasswd> # to enable the bitwarden admin console
	WEBPASSWORD=<piholeadminpasswd> # If it doesn't work in the web console, delete it from `pihole/etc/pihole/setupVars.conf` and restart
	PLEX_MEDIA_PATH=</path/to/media> # location of your music and videos
	ADVERTISE_IP=<plex_domain_or_ip> # your pi's IP address
	PLEX_CLAIM=<plexclaim>  # Get the claim token from https://plex.tv/claim/
	TZ=America/New_York # or your local timezone
	```

8. Run `cron-create-renew-job.sh` to create a cron job that renews the cert and restarts nginx
9. Run `docker-compose up -d`

Run `openvpn-create-client.sh` to create a vpn client profile.

