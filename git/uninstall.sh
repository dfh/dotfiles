#!/usr/bin/env bash
set -euo pipefail

echo
echo "Removing installed files..."
echo

echo -n "  " && rm -v $HOME/.config/git/gitignore || true

echo
echo "Deactivating global gitignore file... "
echo

echo "  git config --get core.excludesfile && git config --global --unset core.excludesfile"
git config --get core.excludesfile && git config --global --unset core.excludesfile

echo
echo "All done."

if [[ -f $HOME/.gitignore ]]; then
    echo
    echo "NOTICE! Found existing ~/.gitignore. It's not activated."
    echo "To activate it, run 'git config --global core.excludesfile ~/.gitignore'"
fi
