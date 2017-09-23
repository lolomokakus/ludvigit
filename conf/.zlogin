if [[ -v SSH_CONNECTION ]] ; then
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

export PATH="$HOME/.local/bin:$PATH:."

neofetch --config "$HOME/.login_neofetch"

unsetopt no_match
if ! ls /var/lib/dkms/nvidia/*mainline* >/dev/null 2>&1 && uname -r | grep mainline >/dev/null 2>&1 ; then
	echo -e "\033[1;31mNOTE: THE NVIDIA DRIVER IS BROKEN ON MAINLINE AGAIN\033[0m"
fi
setopt no_match
