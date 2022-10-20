#!/usr/bin/env bash
set -euo pipefail

echo
echo "Copying new files in place..."
echo

echo -n "  " && rm -i "$HOME/.config/git/gitignore" || true
if [[ -f "$HOME/.config/git/gitignore" ]]; then
    echo
    echo "Existing gitignore not deleted. Aborting."
    exit 1
fi
echo -n "  " && mkdir -v "$HOME/.config/git" || true
echo -n "  " && cp -v gitignore "$HOME/.config/git/gitignore"

echo
echo "Activating new global gitignore..."
echo

echo "  git config --global core.excludesfile ~/.config/git/gitignore"
git config --global core.excludesfile ~/.config/git/gitignore

echo
echo "New global gitignore installed to: ~/.config/git/gitignore"
echo
echo "Setting name and email..."
echo

echo "  git config --global user.name \"David Högberg\""
git config --global user.name "David Högberg"
echo "  git config --global user.name \"david@hgbrg.se\""
git config --global user.email "david@hgbrg.se"

echo
echo "All done."

if [[ -f $HOME/.gitignore ]]; then
    echo
    echo "NOTICE: Found existing ~/.gitignore. It won't be used anymore."
fi

