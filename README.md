> **LipCord** is a Linux port of [RipCord](https://github.com/kclose3/RipCord) by [KClose](https://github.com/kclose3), based on an idea by reddit user u/SATLTSADWFZ. All credit for the original concept and macOS implementation goes to them.

---

### LipCord - Automatically Lock & Suspend when USB Drive is Removed
&emsp;&emsp;v0.1.0

About this script:<br>
The intent of this project was to make a failsafe that would put a computer to sleep if someone were to steal the computer from someone sitting in public. This works by having a "key" drive that would be tethered to the user like a ripcord. If the computer were taken away forcefully, the USB drive would be removed and the computer will lock and suspend.

This works by installing a script that checks for the presence or absence of a USB drive specifically named *RipCord*. If at any point in time, the *RipCord* drive is removed, the computer will immediately lock the session and suspend. The script runs automatically upon installation as a systemd user service, and also on login, ensuring that the safety protocol is constantly in effect.

The USB drive does not need to be present at all times, only if you believe your computer might be at risk. Removing the USB drive locks and suspends the computer, but only upon initial removal after being inserted. If you unlock the computer after the drive has been removed, it will not lock again until the drive has been reinserted and removed again.

---

### Compatibility

LipCord works on any Linux system with systemd. It tries the following lock methods in order:

1. `loginctl lock-session` (systemd - works with most DEs and compositors)
2. D-Bus `org.freedesktop.ScreenSaver.Lock` (GNOME, KDE, XFCE, etc.)
3. Direct locker detection: hyprlock, swaylock, waylock, i3lock, xdg-screensaver, xscreensaver

Suspend is handled via `systemctl suspend`.

---

This script will install the following files:
- `~/.local/bin/lipcord`
- `~/.config/systemd/user/lipcord.service`
- `~/.config/lipcord/config`

To install LipCord:
1. Clone this repository or download the files
2. Run `./install.sh` to complete the installation and start the USB monitor
3. Ensure your screen locker requires a password on wake/unlock (this is the default for most Linux setups)
4. Rename a USB drive as *RipCord*

To use LipCord:<br>
LipCord starts running upon installation and will launch automatically at every login. Inserting the *RipCord* USB drive will "arm" the system. The next time the drive is removed, the computer will lock and suspend.

Check status:
```
systemctl --user status lipcord
```

To uninstall LipCord:
1. Run `./uninstall.sh`
2. Or manually: delete the files noted above, then run `systemctl --user daemon-reload`

---

### Configuration

Edit `~/.config/lipcord/config` to customize behavior:

```bash
# Lock the session when RipCord is removed (yes/no)
LOCK=yes

# Suspend the system when RipCord is removed (yes/no)
SUSPEND=yes

# USB drive label to monitor
LABEL=RipCord

# Polling interval in seconds
POLL_INTERVAL=1
```

---

ChangeLog
- 2026.03.27	-	Initial release (Linux port)
