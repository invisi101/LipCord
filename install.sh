#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/lipcord"
SERVICE_DIR="$HOME/.config/systemd/user"

echo "=== LipCord Installer ==="
echo

# Install the monitoring script
mkdir -p "$HOME/.local/bin"
cp "$SCRIPT_DIR/lipcord" "$HOME/.local/bin/lipcord"
chmod +x "$HOME/.local/bin/lipcord"
echo "[+] Installed lipcord to ~/.local/bin/lipcord"

# Install default config if none exists
mkdir -p "$CONFIG_DIR"
if [ ! -f "$CONFIG_DIR/config" ]; then
    cat > "$CONFIG_DIR/config" << 'EOF'
# LipCord Configuration

# Lock the session when RipCord is removed (yes/no)
LOCK=yes

# Suspend the system when RipCord is removed (yes/no)
SUSPEND=yes

# USB drive label to monitor
LABEL=RipCord

# Polling interval in seconds
POLL_INTERVAL=1
EOF
    echo "[+] Created default config at $CONFIG_DIR/config"
else
    echo "[=] Config already exists at $CONFIG_DIR/config (kept existing)"
fi

# Install systemd user service
mkdir -p "$SERVICE_DIR"
cp "$SCRIPT_DIR/lipcord.service" "$SERVICE_DIR/lipcord.service"
echo "[+] Installed systemd user service"

# Enable and start the service
systemctl --user daemon-reload
systemctl --user enable lipcord.service
systemctl --user start lipcord.service
echo "[+] Enabled and started lipcord service"

echo
echo "=== LipCord is now active ==="
echo "Plug in a USB drive labeled 'RipCord' to arm it."
echo "Edit $CONFIG_DIR/config to customize behavior."
echo "Check status: systemctl --user status lipcord"
