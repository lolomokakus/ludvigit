#!/usr/bin/env bash
BINDIR="$(cd $(dirname $0)/../bin && pwd)"
SRCDIR="$(cd $(dirname $0)/../src && pwd)"
rm -r "$HOME/.local/bin"
ln -sv "$BINDIR" "$HOME/.local/bin"
cd "$SRCDIR"
echo "collatz.hs"
ghc -Wall -fno-warn-tabs -dynamic "collatz.hs" -o "$BINDIR/collatz"
echo "collatzall.hs"
ghc -Wall -fno-warn-tabs -dynamic "collatzall.hs" -o "$BINDIR/collatzall"
echo "piano.c"
gcc -Wall "piano.c" -lm -o "$BINDIR/piano"
echo "sus.hs"
ghc -Wall -fno-warn-tabs -dynamic "sus.hs" -o "$BINDIR/sus"
echo "typewrite.c"
gcc -Wall "typewrite.c" -lm -o "$BINDIR/typewrite"
sudo cp -v "$BINDIR/piano" "/usr/local/bin/setuid-piano"
sudo chmod -v +s "/usr/local/bin/setuid-piano"
sudo cp -v "$BINDIR/typewrite" "/usr/local/bin/setuid-typewrite"
sudo chmod -v +s "/usr/local/bin/setuid-typewrite"
