#!/usr/bin/env bash
set -e

echo "🚀 Installing J'SOS..."

# Install directories
sudo mkdir -p /usr/local/share/jsos-shell
sudo mkdir -p /usr/local/share/jsos-wm

# Copy shell
sudo cp -r "$(dirname "$0")"/../jsos-shell/* /usr/local/share/jsos-shell/

# Copy sway config
sudo cp "$(dirname "$0")"/../jsos-wm/sway-config /usr/local/share/jsos-wm/sway-config

# Copy launcher script
sudo cp "$(dirname "$0")"/../jsos-wm/jsos-session /usr/local/bin/jsos-session
sudo chmod +x /usr/local/bin/jsos-session

# Copy launcher script
sudo cp "$(dirname "$0")"/../jsos-wm/jsos-launcher.mjs /usr/local/bin/jsos-launcher.mjs
sudo chmod +x /usr/local/bin/jsos-launcher.mjs

# Copy session entry
sudo cp "$(dirname "$0")"/../jsos-wm/jsos.desktop /usr/share/wayland-sessions/jsos.desktop

echo "J'SOS installed!"
echo "Select J'SOS from the login screen to begin."
