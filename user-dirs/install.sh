#!/usr/bin/env bash
set -euo pipefail

echo "Installing files..."
echo

cp -v --interactive user-dirs.dirs ~/.config/
cp -v --interactive user-dirs.locale ~/.config/

echo
echo "All done."
