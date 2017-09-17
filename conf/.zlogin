export PATH="$HOME/.local/bin:$PATH:."

if [[ -n "$(command -v neofetch)" && -e "$HOME/.login_neofetch" && -e "$HOME/.login_ascii" ]] ; then
	neofetch --config "$HOME/.login_neofetch"
fi

if [[ -n "$(command -v setuid-piano)" && -n "$SSH_CONNECTION" && ! -x "$HOME/.quickly_and_quietly" ]] ; then
	setuid-piano 40 100
	setuid-piano 47 400
fi
