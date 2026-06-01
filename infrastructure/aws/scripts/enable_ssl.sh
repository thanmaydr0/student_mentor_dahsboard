#!/bin/bash
# Script to install Caddy and enable SSL for Supabase

DOMAIN="db.teser.in"

echo "Installing Caddy..."
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy -y

echo "Configuring Caddy to proxy traffic to Supabase (Port 8000)..."
cat <<EOF | sudo tee /etc/caddy/Caddyfile
$DOMAIN {
    reverse_proxy localhost:8000
}
EOF

echo "Restarting Caddy..."
sudo systemctl restart caddy

echo "Done! Supabase is now secured with SSL at https://$DOMAIN"
