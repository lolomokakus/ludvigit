export PATH="$HOME/.local/bin:$PATH:."

if [[ -e "$HOME/.login_art" ]] ; then
	source "$HOME/.login_art"
	base64 -d <<<$ART | gunzip
	unset ART
	echo
fi

if [[ -n "$(command -v setuid-piano)" && -n "$SSH_CONNECTION" && ! -x "$HOME/.quickly_and_quietly" ]] ; then
	setuid-piano 40 100
	setuid-piano 47 400
fi
