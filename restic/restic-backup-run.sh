#!/usr/bin/env bash
set -euo pipefail

#
# This script is normally run by systemd, with variables set by
# ~/.config/restic/restic-backup.conf
#
# If run from the command line, the variables must be set in the environment.
#
# Sometimes my network connection can be a bit shaky. So there is a built in
# mechanism to retry if failed, with a 10 seconds wait in between tries. The
# numer of times to try can be given as an integer argument. The default is to
# try just one time.
#

n=1
if [[ $# != 0 ]] && [ $1 -eq $1 ] 2> /dev/null; then
    n=$1
else
    echo "First argument must be an integer."
    exit 1
fi

notify-send "Starting backup." || true

i=1
success="false"
while [ $i -le $n ] && [[ "$success" == "false" ]]; do
    echo "Running backup. Attempt $i/$n."
    echo
    start=$(date +%s)
    if ! $RESTIC_BIN --repo "$RESTIC_TARGET" backup "$RESTIC_SOURCE" --exclude-file "$RESTIC_EXCLUDE_FILE" --exclude-if-present "__nobackup__" -o sftp.connections=4; then
        echo
        echo -n "Backup attempt $i/$n failed."
        if [ $i -lt $n ]; then
            echo " Sleeping for 10 seconds until trying again..."
            sleep 10
        fi
        echo
    else
        success="true"
    fi
    end=$(date +%s)
    i=$(( $i + 1 ))
done

if [[ "$success" == "false" ]]; then
    echo
    echo "ERROR: All attempts failed. Nothing was backed up."
    notify-send "Backup failed. See 'journalctl --user -xe' for more details." || true
    exit 1
fi

mins=$(((end - start) / 60))
secs=$(((end - start) % 60))

notify-send "Backup completed in ${mins}m${secs}s." || true
