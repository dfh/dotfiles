#!/usr/bin/env bash
set -euo pipefail

echo "Backing up existing files..."
echo

#
# --no-clobber makes cp not overwrite existing target.
#
# --no-target-directory makes cp not create a subdirectory within the target
# directory if it already exists.
#
# The "|| true" thing avoids exiting with error if target file already exists.
#
cp -v --no-clobber ~/.zshenv ~/.zshenv.orig || true
cp -v --no-clobber ~/.config/zsh/.zshrc ~/.config/zsh/.zshrc.orig || true
cp -v --no-clobber ~/.config/zsh/.zimrc ~/.config/zsh/.zimrc.orig || true
cp -v --no-clobber --recursive --no-target-directory ~/.config/zsh/asciiship-djf ~/.config/zsh/asciiship-djf.orig || true

echo
echo "Copying new files in place..."
echo

cp -v zshenv ~/.zshenv
cp -v zshrc ~/.config/zsh/.zshrc
cp -v zimrc ~/.config/zsh/.zimrc
cp -v --recursive --no-target-directory asciiship-djf ~/.config/zsh/asciiship-djf

echo
echo "All done."
