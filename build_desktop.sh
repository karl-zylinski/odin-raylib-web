#!/bin/bash -eu

OUT_DIR="build/desktop"
mkdir -p $OUT_DIR
odin build source/main_desktop -vet -strict-style -out:$OUT_DIR/game_desktop.bin
cp -R ./assets/ ./$OUT_DIR/assets/
echo "Desktop build created in ${OUT_DIR}"