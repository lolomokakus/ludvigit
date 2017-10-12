export PATH="$HOME/.local/bin:$PATH:."

if [[ -v SSH_TTY ]] ; then
	function login_sound {
		setuid-piano 59 170
		setuid-piano 58 170
		setuid-piano 55 170
		setuid-piano 49 170
		setuid-piano 48 170
		setuid-piano 56 170
		setuid-piano 60 170
		setuid-piano 64 170
	}
	login_sound &!
	unfunction login_sound
fi

neofetch --config "$HOME/.login_neofetch"

unsetopt no_match
if ! ls -1U /var/lib/dkms/nvidia/*mainline* >/dev/null 2>&1 && uname -r | grep mainline >/dev/null 2>&1 ; then
	printf "\x1b[1;31mNOTE: THE NVIDIA DRIVER IS BROKEN ON MAINLINE AGAIN\x1b[0m\n"
fi
setopt no_match
