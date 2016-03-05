# sshbeep v1.4
# beeps if logged in via ssh
# made by Ludvig Holtze
# licensed WTFPL

# test if beep is installed, we're connected via ssh and if beeping on ssh login is enabled or not
if [ -n "$(command -v beep)" -a -n "$SSH_CONNECTION" -a ! -x "$HOME/.quickly_and_quietly" ]; then
	# a nice little chime
	beep -f 261.63 -l 100
	beep -f 392 -l 400
fi
