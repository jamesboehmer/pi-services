# pi-services

This project is a collection of docker containers that I run on my raspberry pi 4.  It's a powerhouse little box, but also a little challenging to find armv7 docker images for.  I run this docker-compose setup from an external drive directory, so if I replace my pi I won't lose my data.

Generate a Letsencrypt cert for your personal domain, set a handful of configs in `.env` and run `docker-compose up -d` to start everything.  Expose external ports 60888/tcp for Bitwarden, and 1194/udp for OpenVPN.  Ports 80/443 also expose pihole admin, plex media server, and gitbucket, but I personally keep them only on my internal network.

## Setup

1. Run `git submodule init && git submodule update`
2. Run `certbot-create.sh` to create letsencrypt certs e.g. `certbot-create.sh '*.mydomain.com'`
3. Run `nginx-create-dhparams.sh` to create a new dhparams.pem 
4. Edit `ddclient/config/ddclient.conf.example` and save as `ddclient/config/ddclient.conf`
5. Run `openvpn-init.sh` to initialize the openvpn server, e.g. `openvpn-init.sh subdomain.mydomain.com`
6. Add the following to `.env`:

	```
	ADMIN_TOKEN=<bitwardenadminpasswd> # to enable the bitwarden admin console
	WEBPASSWORD=<piholeadminpasswd> # If it doesn't work in the web console, delete it from `pihole/etc/pihole/setupVars.conf` and restart
	PLEX_MEDIA_PATH=</path/to/media> # location of your music and videos
	ADVERTISE_IP=<plex_domain_or_ip> # your pi's IP address
	PLEX_CLAIM=<plexclaim>  # Get the claim token from https://plex.tv/claim/
	TZ=America/New_York # or your local timezone
	LETS_ENCRYPT_CERT=<basedomain_of_your_letsencrypt_cert_for_nginx> # e.g. mydomain.com
	```

7. Run `cron-create-renew-job.sh` to create a cron job that renews the cert and restarts nginx
8. Run `docker-compose up -d`

## Hosts/ports

* Bitwarden: `https://bw.<mydomain.com>:60888`
* OpenVPN: `subdomain.<mydomain.com>:1194` (udp)
* Pihole admin: `https://pihole.<mydomain.com>:443`
* Plex: `https://plex.<mydomain.com>:443`
* Gitbucket: `https://gitbucket.<mydomain.com>:443`

## Creating VPN client configs

Run `openvpn-create-client.sh` to create a vpn client profile.

