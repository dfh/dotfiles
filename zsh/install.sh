#!/usr/bin/env bash
set -euo pipefail

echo "Installing files..."
echo

#
# "|| true" makes the script not exit with error if files are not found.
#

cp -v --interactive zshenv ~/.zshenv
cp -v --interactive zshrc ~/.config/zsh/.zshrc
cp -v --interactive zimrc ~/.config/zsh/.zimrc
cp -v --interactive --recursive asciiship-djf ~/.config/zsh/asciiship-djf

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
