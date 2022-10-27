#!/usr/bin/env bash
set -euo pipefail

echo "Deleting files..."
echo

# "|| true" makes script not exit if files not found.

rm -v --interactive ~/.config/user-dirs.dirs || true
rm -v --interactive ~/.config/user-dirs.locale || true

echo
echo "All done."
