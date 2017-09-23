export EDITOR='nano'
export LESS='-FKMR'
export LS_COLORS="di=01;35:ln=01;36:so=01;32:pi=01;32:ex=01;31:bd=01;33:cd=01;33:su=01;31;47:sg=01;31;47:tw=01;35;44:ow=01;35;44"
export PAGER='less'

if [[ -v SSH_CONNECTION || ! -v DISPLAY ]] ; then
	export BROWSER='w3m'
else
	export BROWSER='firefox'
fi
