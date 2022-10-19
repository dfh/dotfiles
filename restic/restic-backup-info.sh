#!/usr/bin/env bash
set -euo pipefail

echo "Restic info"
echo
echo "----"
echo
echo "Settings"
echo
echo "Target repo:  $RESTIC_TARGET"
echo "Source:       $RESTIC_SOURCE"
echo "Exclude file: $RESTIC_EXCLUDE_FILE"
echo "Command:      $RESTIC_BIN"

echo
echo "----"
echo
echo "Repo statistics"
echo
restic --repo $RESTIC_TARGET stats

echo
echo "----"
echo
echo "Systemd status"
echo

# systemctl exits with code 3 even though successful for whatever reason
systemctl --user status --full --no-pager restic-backup || true
