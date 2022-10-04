#!/usr/bin/env bash
set -euo pipefail

echo "Restoring original files:"
echo

#
# --force makes mv overwrite target without asking.
#
# the "|| true" thing makes mv not exit with error if target does not exist.
#
mv -v ~/.zshenv.orig ~/.zshenv || true
mv -v ~/.config/zsh/.zshrc.orig ~/.config/zsh/.zshrc || true
mv -v ~/.config/zsh/.zimrc.orig ~/.config/zsh/.zimrc || true
mv -v --force ~/.config/zsh/asciiship-djf.orig/ ~/.config/zsh/asciiship-djf || true

echo
echo "All done."
