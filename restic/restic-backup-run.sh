#!/usr/bin/env bash
set -euo pipefail

#
# This script is normally run by systemd, with variables set by
# ~/.config/restic/restic-backup.conf
#
# If run from the command line, the variables must be set in the environment.
#

notify-send "Starting backup." || true

start=$(date +%s)
if ! $RESTIC_BIN --repo "$RESTIC_TARGET" backup "$RESTIC_SOURCE" --exclude-file "$RESTIC_EXCLUDE_FILE" --exclude-if-present "__nobackup__" -o sftp.connections=4; then
    notify-send "Backup failed. See 'journalctl --user -xe' for more details." || true
    exit 1
fi
end=$(date +%s)

mins=$(((end - start) / 60))
secs=$(((end - start) % 60))

notify-send "Backup completed in ${mins}m${secs}s." || true
