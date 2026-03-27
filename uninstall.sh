#!/usr/bin/env bash
set -euo pipefail

SERVICE_DIR="$HOME/.config/systemd/user"

echo "=== LipCord Uninstaller ==="
echo

# Stop and disable the service
if systemctl --user is-active lipcord.service &>/dev/null; then
    systemctl --user stop lipcord.service
    echo "[+] Stopped lipcord service"
fi

if systemctl --user is-enabled lipcord.service &>/dev/null; then
    systemctl --user disable lipcord.service
    echo "[+] Disabled lipcord service"
fi

# Remove files
rm -f "$HOME/.local/bin/lipcord"
echo "[+] Removed ~/.local/bin/lipcord"

rm -f "$SERVICE_DIR/lipcord.service"
systemctl --user daemon-reload 2>/dev/null
echo "[+] Removed systemd user service"

echo
read -rp "Remove config at ~/.config/lipcord/? [y/N] " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    rm -rf "${XDG_CONFIG_HOME:-$HOME/.config}/lipcord"
    echo "[+] Removed config"
else
    echo "[=] Config kept"
fi

echo
echo "=== LipCord has been uninstalled ==="
