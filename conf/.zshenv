export EDITOR='nano'
export LESS='FKMRX'
export LS_COLORS="di=1;35:ln=1;36:so=1;32:pi=1;32:ex=1;31:bd=1;33:cd=1;33:su=1;31;47:sg=1;31;47:tw=1;35;44:ow=1;35;44"
export PAGER='less'

if [[ -v SSH_TTY || "$TERM" = "linux" ]] ; then
	export BROWSER='w3m'
else
	export BROWSER='firefox'
fi
