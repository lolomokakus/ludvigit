export PATH="$HOME/bin:$PATH:."

if [[ -e "$HOME/.login_art" ]] ; then
	source "$HOME/.login_art"
	base64 -d <<<$ART | gunzip
	unset ART
fi

if [[ -n "$(command -v tone)" && -n "$SSH_CONNECTION" && ! -x "$HOME/.quickly_and_quietly" ]] ; then
	tone c4 100 g4 400
fi
