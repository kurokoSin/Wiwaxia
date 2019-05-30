#!/usr/bin/env bash
# DNS config
sed -i.bak -e "s/^DNS=.*$/DNS=8.8.8.8 192.168.122.1/g" /etc/systemd/resolved.conf
systemctl restart systemd-resolved.service

sudo apt-get update
sudo snap install wekan
sudo snap set wekan root-url="http://localhost:8080"
sudo systemctl restart snap.wekan.wekan
