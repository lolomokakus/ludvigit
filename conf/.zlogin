export PATH="$HOME/.local/bin:$PATH:."

neofetch --config "$HOME/.login_neofetch"

if [[ ! -v SSH_CONNECTION ]] && ! lsmod | grep nvidia >/dev/null && uname -r | grep mainline >/dev/null ; then
	echo -e "\033[1;31mNOTE: THE NVIDIA DRIVER IS BROKEN ON MAINLINE AGAIN\033[0m"
fi

if [[ -v SSH_CONNECTION && ! -x "$HOME/.quickly_and_quietly" ]] ; then
	setuid-piano 59 170
	setuid-piano 58 170
	setuid-piano 55 170
	setuid-piano 49 170
	setuid-piano 48 170
	setuid-piano 56 170
	setuid-piano 60 170
	setuid-piano 64 170
fi
