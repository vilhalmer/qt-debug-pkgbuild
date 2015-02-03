#!/bin/bash

set -e
dir="$PWD"
outdir=/srv/http/qutebrowser/qt-debug/x86_64

if [[ $1 == repackage ]]; then
    makepkg_opts=('-siR' '--config' "$dir/makepkg.conf")
else
    makepkg_opts=('-si' '--config' "$dir/makepkg.conf")
fi

cd "$dir/qt5"
rm *.pkg.tar* || true
rm -r src/python2-path || true
makepkg "${makepkg_opts[@]}"
mv *.pkg.tar.xz* "$outdir"

cd "$dir/pyqt5"
rm *.pkg.tar* || true
makepkg "${makepkg_opts[@]}"
mv *.pkg.tar.xz* "$outdir"

repo-add "$outdir/qt-debug.db.tar.gz" "$outdir"/*.pkg.tar.xz

cd "$dir"
