export PATH="$HOME/.local/bin:$PATH:."

neofetch --config "$HOME/.login_neofetch"

if [[ "$TTY" = "/dev/tty1" ]]; then
	read -k 1 "sway?Är det dags för lite grafik [J/n]? "
	echo
	if [[ ! ("$sway" = "N" || "$sway" = "n") ]]; then
		env XKB_DEFAULT_LAYOUT=se sway
	fi
	unset sway
fi
