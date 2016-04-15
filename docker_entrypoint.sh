#!/bin/bash

set -e

[[ ! $PACKAGES ]] && PACKAGES=$(cat pkglist)

for pkg in $PACKAGES; do
    cd ~/$pkg
    # Remove the thing we're building so we can install -debug easily.
    sudo pacman -Rdd --noconfirm $pkg
    makepkg -i -f --noconfirm
done