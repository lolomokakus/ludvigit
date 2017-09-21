export PATH="$HOME/.local/bin:$PATH:."

neofetch --config "$HOME/.login_neofetch"

if [[ -z "$(lsmod | grep nvidia)" && -n "$(uname -r | grep mainline)" ]] ; then
	echo -e "\033[1;31mNOTE: THE NVIDIA DRIVER IS BROKEN ON MAINLINE AGAIN\033[0m"
fi

if [[ -n "$SSH_CONNECTION" && ! -x "$HOME/.quickly_and_quietly" ]] ; then
	piano 59 170
	piano 58 170
	piano 55 170
	piano 49 170
	piano 48 170
	piano 56 170
	piano 60 170
	piano 64 170
fi
