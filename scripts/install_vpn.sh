#!/usr/bin/env bash
set -euo pipefail

# Basic bootstrap placeholder — safe to run
apt-get update -y
apt-get install -y wireguard qrencode

# Enable IPv4 forwarding (required for VPN)
sysctl -w net.ipv4.ip_forward=1
sed -i 's/^#\?net.ipv4.ip_forward=.*/net.ipv4.ip_forward=1/' /etc/sysctl.conf

echo "VPN bootstrap complete" | tee /var/log/vpn_bootstrap.log
