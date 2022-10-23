#!/usr/bin/env bash
set -euo pipefail

echo "Deleting files..."
echo

#
# "|| true" makes the script not exit with error if files are not found.
#
#
echo -n "  " && rm -v --interactive ~/.zshenv || true
echo -n "  " && rm -v --interactive ~/.config/zsh/.zshrc || true
echo -n "  " && rm -v --interactive ~/.config/zsh/.zimrc || true
echo -n "  " && rm -v --interactive --recursive ~/.config/zsh/asciiship-djf || true

echo
echo "All done."
echo

echo "NOTICE: $HOME/.config/secrets.sh must be removed manually."
