#!/usr/bin/env bash
set -euo pipefail

echo "Checking if repository exists (you might have to enter the repo password)..."
if restic snapshots --repo "$RESTIC_TARGET" > /dev/null; then
    echo "  Repository found: $RESTIC_TARGET"
else
    echo "  ERROR: Repo '$RESTIC_TARGET' does not exist. Please create it."
    exit 1
fi

echo
echo "Checking for restic systemd service configuration file..."

if [ ! -f "$HOME/.config/restic/restic-backup.conf" ]; then
    echo "  ERROR: Systemd configuration file '$HOME/.config/restic/restic-backup.conf' not found."
    echo
    echo "  For an example, see 'restic-backup.conf.example'."
    exit 1
else
    echo "  Found configuration file: $HOME/.config/restic/restic-backup.conf"
fi

echo
echo "Installing files..."

if [[ ! -f "$RESTIC_EXCLUDE_FILE" ]]; then
    echo "  ERROR: Restic exclude file '$RESTIC_EXCLUDE_FILE' not found."
    exit 1
fi

echo -n "  " && cp -iv restic-backup-run.sh "$HOME/bin/restic-backup-run.sh"
echo -n "  " && cp -iv restic-backup-init-repo.sh "$HOME/bin/restic-backup-init-repo.sh"
echo -n "  " && cp -iv restic-backup-info.sh "$HOME/bin/restic-backup-info.sh"
echo -n "  " && cp -iv restic-backup.service "$HOME/.config/systemd/user/restic-backup.service"
echo -n "  " && cp -iv restic-backup.timer "$HOME/.config/systemd/user/restic-backup.timer"

echo
echo "Reloading systemd..."

echo "  systemctl --user daemon-reload"
systemctl --user daemon-reload

echo "  systemctl --user enable --now restic-backup.timer"
echo -n "    "
systemctl --user enable --now restic-backup.timer

echo
echo "Installation complete. Backup will run daily."

if ! which notify-send > /dev/null; then
    echo
    echo "NOTICE: notify-send' not found. Will not send desktop notifications."
    echo "        Install by running 'sudo apt install libnotify-bin'."
fi
