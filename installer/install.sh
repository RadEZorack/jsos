#!/usr/bin/env bash
set -e

echo "🚀 Installing J'SOS + Sky98 Desktop Environment..."

echo "🔍 Stopping any running J’SOS processes..."
sudo pkill -f jsos-launcher 2>/dev/null || true
sudo pkill -f jsos-session 2>/dev/null || true

ROOT="$(dirname "$0")/.."
USER_NAME="${SUDO_USER:-$USER}"

# ---------------------------------------------------------------------
# 1. Install J’SOS Web Shell + WM folder structure
# ---------------------------------------------------------------------
sudo mkdir -p /usr/local/share/jsos-shell
sudo mkdir -p /usr/local/share/jsos-wm

echo "📁 Copying Web Shell..."
sudo cp -r "$ROOT/jsos-shell/"* /usr/local/share/jsos-shell/

echo "📁 Copying Sway config + Session script..."
sudo cp "$ROOT/jsos-wm/sway-config" /usr/local/share/jsos-wm/sway-config
sudo cp "$ROOT/jsos-wm/jsos-session" /usr/local/bin/jsos-session
sudo chmod +x /usr/local/bin/jsos-session

# ---------------------------------------------------------------------
# 2. Install Rust-native launcher
# ---------------------------------------------------------------------
echo "🦀 Installing Rust launcher..."
if [ -f "$ROOT/jsos-launcher/target/release/jsos-launcher" ]; then
    sudo cp "$ROOT/jsos-launcher/target/release/jsos-launcher" /usr/local/bin/jsos-launcher
    sudo chmod +x /usr/local/bin/jsos-launcher
    echo "✅ Installed Rust launcher."
else
    echo "❌ Rust launcher not found!"
    echo "Build first:"
    echo "  cd jsos-launcher && cargo build --release"
    exit 1
fi

# ---------------------------------------------------------------------
# 3. Install Wayland session for J’SOS
# ---------------------------------------------------------------------
echo "🖥️ Registering J’SOS session..."

sudo bash -c "cat > /usr/share/wayland-sessions/jsos.desktop" <<EOF
[Desktop Entry]
Name=J'SOS
Comment=Sky98 Desktop Environment
Exec=/usr/local/bin/jsos-session
TryExec=/usr/local/bin/jsos-session
Type=WaylandSession
DesktopNames=JSOS
EOF

sudo chmod 644 /usr/share/wayland-sessions/jsos.desktop

# ---------------------------------------------------------------------
# 4. Force J’SOS as the system default session for the user
# ---------------------------------------------------------------------
echo "⚙️ Setting J’SOS as default session via AccountsService..."

sudo mkdir -p /var/lib/AccountsService/users
sudo bash -c "cat > /var/lib/AccountsService/users/$USER_NAME" <<EOF
[User]
XSession=jsos
EOF

# ---------------------------------------------------------------------
# 5. Make .dmrc match the J’SOS session
# ---------------------------------------------------------------------
echo "📝 Writing ~/.dmrc for user..."
sudo -u "$USER_NAME" bash -c "echo '[Desktop]' > ~/.dmrc"
sudo -u "$USER_NAME" bash -c "echo 'Session=jsos' >> ~/.dmrc"

# ---------------------------------------------------------------------
# 6. Auto-login configuration for GDM
# ---------------------------------------------------------------------
echo "🔓 Enabling auto-login for $USER_NAME..."

sudo bash -c "cat > /etc/gdm3/custom.conf" <<EOF
[daemon]
AutomaticLogin=$USER_NAME
AutomaticLoginEnable=true
EOF

# ---------------------------------------------------------------------
# 7. Install Sky98 login theme (for GDM)
# ---------------------------------------------------------------------
echo "🎨 Installing Sky98 login theme..."

THEME_DIR="/usr/share/gnome-shell/theme/Yaru"
THEME_FILE="$THEME_DIR/gnome-shell.css"

if [ ! -f "$THEME_FILE" ]; then
    echo "❌ Could not find $THEME_FILE"
    exit 1
fi

# Backup original once
if [ ! -f "${THEME_FILE}.backup" ]; then
    echo "📦 Backing up Yaru theme..."
    sudo cp "$THEME_FILE" "${THEME_FILE}.backup"
fi

# Apply Sky98 greeter theme
sudo cp "$ROOT/assets/greeter.css" "$THEME_FILE"

# Wallpaper override
sudo cp "$ROOT/assets/wallpaper.png" /usr/share/backgrounds/jsos_wallpaper.png

sudo sed -i 's|#lockDialogGroup {.*|#lockDialogGroup { background: url("/usr/share/backgrounds/jsos_wallpaper.png") !important; background-size: cover !important; }|g' "$THEME_FILE"

# ---------------------------------------------------------------------
# 8. Install Plymouth (Sky98 boot splash)
# ---------------------------------------------------------------------
echo "🌅 Installing Sky98 boot splash..."

sudo mkdir -p /usr/share/plymouth/themes/sky98
sudo cp "$ROOT/assets/plymouth/sky98/sky98.plymouth" /usr/share/plymouth/themes/sky98/
sudo cp "$ROOT/assets/plymouth/sky98/sky98.script" /usr/share/plymouth/themes/sky98/
sudo cp "$ROOT/assets/plymouth/sky98/sky98.png" /usr/share/plymouth/themes/sky98/

sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth \
    /usr/share/plymouth/themes/sky98/sky98.plymouth 100

sudo update-alternatives --set default.plymouth /usr/share/plymouth/themes/sky98/sky98.plymouth

sudo update-initramfs -u

# ---------------------------------------------------------------------
# 9. Boot chime sound
# ---------------------------------------------------------------------
echo "🔊 Installing Sky98 boot chime..."

sudo mkdir -p /usr/share/jsos/sounds
sudo cp "$ROOT/assets/sound/boot_chime.wav" /usr/share/jsos/sounds/

sudo bash -c "cat > /usr/local/bin/jsos-bootsound" <<EOF
#!/bin/bash
aplay /usr/share/jsos/sounds/boot_chime.wav 2>/dev/null &
EOF
sudo chmod +x /usr/local/bin/jsos-bootsound

# Add autostart to Sway config if missing
if ! grep -q jsos-bootsound /usr/local/share/jsos-wm/sway-config; then
    echo "exec_always /usr/local/bin/jsos-bootsound" | sudo tee -a /usr/local/share/jsos-wm/sway-config >/dev/null
fi

# ---------------------------------------------------------------------
# 10. Install Dashboard (Next.js build output)
# ---------------------------------------------------------------------
echo "📦 Installing Sky98 Dashboard/UI..."
sudo mkdir -p /usr/share/jsos/jsos-dashboard
sudo cp -r "$ROOT/jsos-dashboard/"* /home/parallels/jsos/jsos-dashboard/

# ---------------------------------------------------------------------
# 11. Final message
# ---------------------------------------------------------------------
echo "🎉 Sky98 Desktop + J’SOS fully installed!"
echo "➡️ Reboot to auto-load directly into J’SOS."
