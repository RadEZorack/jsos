#!/usr/bin/env bash

set -e

echo "Installing J'SOS..."

sudo mkdir -p /usr/local/share/jsos-shell
sudo mkdir -p /usr/local/share/jsos-wm

sudo cp -r ../jsos-shell/* /usr/local/share/jsos-shell/
sudo cp ../jsos-wm/jsos-session /usr/local/bin/jsos-session
sudo cp ../jsos-wm/jsos.desktop /usr/share/wayland-sessions/

sudo chmod +x /usr/local/bin/jsos-session

echo "Done!"
echo "Launch J’SOS with:  jsos-session"
