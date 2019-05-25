#!/bin/bash
set -e

export NODE_IP="192.168.0.101"

echo "[ INFO ] Copying files to $NODE_IP"
scp -r config/www/* pi@$NODE_IP:/igloo/home-assistant/config/www
scp -r config/panels/* pi@$NODE_IP:/igloo/home-assistant/config/panels
