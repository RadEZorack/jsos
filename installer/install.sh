#!/usr/bin/env bash
set -e

echo "🚀 Installing J'SOS (Rust Edition)..."

ROOT="$(dirname "$0")/.."

# ---------------------------------------------------------
# Install directories
# ---------------------------------------------------------
sudo mkdir -p /usr/local/share/jsos-shell
sudo mkdir -p /usr/local/share/jsos-wm

# ---------------------------------------------------------
# Copy J’SOS web shell (HTML/CSS/JS)
# ---------------------------------------------------------
sudo cp -r "$ROOT/jsos-shell/"* /usr/local/share/jsos-shell/

# ---------------------------------------------------------
# Copy sway config + session script
# ---------------------------------------------------------
sudo cp "$ROOT/jsos-wm/sway-config" /usr/local/share/jsos-wm/sway-config
sudo cp "$ROOT/jsos-wm/jsos-session" /usr/local/bin/jsos-session
sudo chmod +x /usr/local/bin/jsos-session

# ---------------------------------------------------------
# Install Rust-native app launcher
# The Rust binary must be located in:
#   jsos-launcher/target/release/jsos-launcher
# ---------------------------------------------------------
if [ -f "$ROOT/jsos-launcher/target/release/jsos-launcher" ]; then
    sudo cp "$ROOT/jsos-launcher/target/release/jsos-launcher" /usr/local/bin/jsos-launcher
    sudo chmod +x /usr/local/bin/jsos-launcher
    echo "✅ Installed native Rust launcher."
else
    echo "❌ Rust launcher not found!"
    echo "Please build it first:"
    echo "  cd jsos-launcher && cargo build --release"
    exit 1
fi

# ---------------------------------------------------------
# Install Wayland session entry
# ---------------------------------------------------------
sudo cp "$ROOT/jsos-wm/jsos.desktop" /usr/share/wayland-sessions/jsos.desktop

echo "🎉 J'SOS installed!"
echo "➡️  Select 'J’SOS' from the login screen to begin."
