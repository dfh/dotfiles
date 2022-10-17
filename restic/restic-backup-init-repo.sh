#!/usr/bin/env bash
set -euo pipefail

if restic --repo $RESTIC_TARGET stats; then
    echo
    echo "ERROR: Repo '$RESTIC_TARGET' already exists."
    exit 1
else
    restic --repo $RESTIC_TARGET init
fi
