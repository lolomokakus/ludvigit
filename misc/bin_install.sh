#!/usr/bin/env bash
BINDIR="$(cd $(dirname $0)/../bin && pwd)"
SRCDIR="$(cd $(dirname $0)/../src && pwd)"
rm -r "$HOME/.local/bin"
ln -sv "$BINDIR" "$HOME/.local/bin"
echo "typewrite.c"
gcc -Wall -march=native -o "$BINDIR/typewrite" "$SRCDIR/typewrite.c"
echo "piano.c"
gcc -Wall -march=native -o "$BINDIR/piano" "$SRCDIR/piano.c"
