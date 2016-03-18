# test if tone is installed, we're connected via ssh and if beeping on ssh login is enabled or not
if [[ -n "$(command -v tone)" && -n "$SSH_CONNECTION" && ! -x "$HOME/.quickly_and_quietly" ]] ; then
	# a nice little chime
	tone c4 100 g4 400
fi
