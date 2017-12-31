export PATH="$HOME/.local/bin:$PATH:."

neofetch --config "$HOME/.login_neofetch"

if [[ "$TTY" = "/dev/tty1" ]]; then
	read "sway?Är det dags för lite grafik? [J/n] "
	if [[ "$sway" = "J" || "$sway" = "j" || -z "$sway" ]]; then
		env XKB_DEFAULT_LAYOUT=se sway
	fi
	unset sway
fi
