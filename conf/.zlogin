export PATH="$HOME/.local/bin:$PATH:."

neofetch --config "$HOME/.login_neofetch"

if [[ -n "$SSH_CONNECTION" && ! -x "$HOME/.quickly_and_quietly" ]] ; then
	setuid-piano 40 100
	setuid-piano 47 400
fi
