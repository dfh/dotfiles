#!/usr/bin/env bash
set -euo pipefail

echo "Deleting files..."

echo -n "  " && rm -i "$HOME/bin/restic-backup-run.sh" || true
echo -n "  " && rm -i "$HOME/bin/restic-backup-init-repo.sh" || true
echo -n "  " && rm -i "$HOME/bin/restic-backup-info.sh" || true
echo -n "  " && rm -i "$HOME/.config/systemd/user/restic-backup.service" || true
echo -n "  " && rm -i "$HOME/.config/systemd/user/restic-backup.timer" || true

echo
echo "Reloading systemd..."

echo "  systemctl --user daemon-reload"
systemctl --user daemon-reload
echo "  systemctl --user disable restic-backup.timer"
echo -n "    "
systemctl --user disable restic-backup.timer

echo
echo "Uninstallation complete."
echo

echo "NOTICE: The restic repo at '$RESTIC_TARGET' was not deleted."
echo "        The configuration file at '$HOME/.config/restic/restic-backup.conf' was not deleted."
