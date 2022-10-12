#!/usr/bin/env bash
set -euo pipefail

echo
echo "Removing installed files..."
echo

rm -v ~/.zshenv || true
rm -v ~/.config/zsh/.zshrc || true
rm -v ~/.config/zsh/.zimrc || true
rm -vrf ~/.config/zsh/asciiship-djf || true

echo
echo "Restoring original zshenv and zshrc if backups found..."
echo

#((restored = 1)) || true
restored=false
if [[ -f ~/.zshenv.orig ]]; then
    mv -v ~/.zshenv.orig ~/.zshenv
    restored=true
    #((restored++))
fi
if [[ -f ~/.config/zsh/.zshrc.orig ]]; then
    mv -v ~/.config/zsh/.zshrc.orig ~/.config/zsh/.zshrc
#    (( restored++))
    restored=true
fi

if [[ "$restored" = false ]]; then
    echo "No backups found."
fi

echo
echo "All done."
echo

echo "NOTE! ${HOME}/.config/secrets.sh must be removed manually."
