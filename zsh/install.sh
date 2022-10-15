#!/usr/bin/env bash
set -euo pipefail

echo "Backing up existing zshenv and zshrc files (unless backups already exist)..."
echo

backed_up=false
if [[ -f ~/.zshenv && ! -f ~/.zshenv.orig ]]; then
   cp -v ~/.zshenv ~/.zshenv.orig
   backed_up=true
fi
if [[ -f ~/.config/zsh/.zshrc && ! -f ~/.config/zsh/.zshrc.orig ]]; then
   cp -v ~/.config/zsh/.zshrc ~/.config/zsh/.zshrc.orig
   backed_up=true
fi
if [ "$backed_up" = false ]; then
    echo "No files to back up."
fi

echo
echo "Copying new files in place..."
echo

#
# The "|| true" makes the script not exit with error if files are not found.
#

rm -v ~/.zshenv || true
rm -v ~/.config/zsh/.zshrc || true
rm -v ~/.config/zsh/.zimrc || true
rm -vrf ~/.config/zsh/asciiship-djf || true

echo

cp -v zshenv ~/.zshenv
cp -v zshrc ~/.config/zsh/.zshrc
cp -v zimrc ~/.config/zsh/.zimrc
cp -v --recursive asciiship-djf ~/.config/zsh/asciiship-djf

echo

if [[ ! -f ~/.config/secrets.sh ]]; then
    echo "~/.config/secrets.sh does not exist, touching and chmod:ing it."
    touch ~/.config/secrets.sh
    chmod -v 600 ~/.config/secrets.sh
else
    echo "~/.config/secrets.sh already exists, not touching it."
fi

echo
echo "All done."
