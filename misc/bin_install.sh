#!/usr/bin/env bash
BINDIR="$(cd $(dirname $0)/../bin && pwd)"
SRCDIR="$(cd $(dirname $0)/../src && pwd)"
rm -r "$HOME/.local/bin"
ln -sv "$BINDIR" "$HOME/.local/bin"
echo "piano.c"
gcc -Wall -march=native "$SRCDIR/piano.c" -lm -o "$BINDIR/piano"
echo "typewrite.c"
gcc -Wall -march=native "$SRCDIR/typewrite.c" -o "$BINDIR/typewrite"
