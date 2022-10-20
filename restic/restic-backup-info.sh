#!/usr/bin/env bash
set -euo pipefail

echo "RESTIC BACKUP SYSTEM INFO"
echo
echo "----"
echo
echo "SETTINGS"
echo
echo "Target repo:  $RESTIC_TARGET"
echo "Source:       $RESTIC_SOURCE"
echo "Exclude file: $RESTIC_EXCLUDE_FILE"
echo "Command:      $RESTIC_BIN"

echo
echo "----"
echo
echo "REPO STATS"
echo
restic --repo $RESTIC_TARGET stats

echo
echo "----"
echo
echo "SYSTEMD STATUS"
echo

# systemctl exits with code 3 even though successful for whatever reason
systemctl --user status --full --no-pager restic-backup || true
