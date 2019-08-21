#!/bin/bash
set -e

mkdir -p config_copy
cp -R ./config/* ./config_copy
docker run -p 8123:8123 -d -v $PWD/config_copy:/config hckbook/home-assistant
