# load things
autoload -Uz colors && colors
autoload -Uz compinit && compinit
zmodload zsh/complist
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

source /usr/share/doc/pkgfile/command-not-found.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# options
setopt always_to_end
setopt append_history
setopt auto_cd
setopt auto_menu
setopt auto_pushd
setopt cdable_vars
setopt combining_chars
setopt complete_in_word
setopt extended_history
setopt hist_ignore_space
setopt hist_verify
setopt interactive_comments
setopt long_list_jobs
setopt multios
setopt no_check_jobs
setopt no_flow_control
setopt no_hup
setopt no_menu_complete
setopt prompt_subst
setopt pushd_minus
setopt pushd_to_home
setopt share_history

# completion
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache 1
zstyle ':completion:*' cache-path "$HOME/.zsh_cache"

# syntax highlighting
typeset -A ZSH_HIGHLIGHT_STYLES

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# pager
export PAGER="less"
export LESS="-FKMRX"

# editor and browser
if [[ -n "$SSH_CONNECTION" || -z "$DISPLAY" ]] ; then
	export EDITOR="nano"
	export BROWSER="w3m"
else
	export EDITOR="gedit"
	export BROWSER="firefox"
fi

# keybindings
bindkey '\e[A' up-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search

# aliases and functions
alias sudo='sudo ' # this makes aliases work when run with sudo

alias d='dirs -v'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias j='jobs -l'
alias jr='j -r'
alias js='j -s'

alias k='kill'
alias c='k -CONT'
alias s='k -TSTP'

alias pc='pacaur'
alias pcc='pc -Scc'
alias pci='pc -S'
alias pcr='pc -Rsc'
alias pcs='pc -Ss'
alias pcu='pc -Syu'
alias pcud='pcu --devel'

alias g='git'
alias ga='g add'
alias gaa='ga --all'
alias gcl='g clone --recursive'
alias gcm='g commit -vm'
alias gf='g fetch'
alias gl='g pull'
alias gp='g push'
alias gst='g status'

alias shutdown='systemctl poweroff'
alias reboot='systemctl reboot'
alias suspend='systemctl suspend'
alias hibernate='systemctl hibernate'
alias emergency='systemctl emergency'

alias ls='ls --color=auto --group-directories-first'
alias l='ls -lNFh'
alias la='l -A'
alias ldot='l -d .*'

alias cp='cp -ri'
alias mv='mv -i'
alias rm='rm -ri'
alias srm='srm -ri'

alias grep='grep --color=auto -n'
alias G='grep'
alias L='less'

alias cmd="wine cmd"
alias history='fc -il 1 | L +G'
alias manh='man -H'
alias pkgfiles='pkgfile -l'
alias su='sudo -i'
alias x='exit'

function path {
	if [[ -z "$@" ]] ; then
		echo $PATH
	else
		export PATH="$@"
	fi
}

function say {
	if [[ -z "$@" ]] ; then
		echo "Say what?" >&2
		return 1
	fi
	if [[ -t 1 ]] ; then
		espeak -v en --stdout "$@" | paplay
	else
		espeak -v en --stdout "$@"
	fi
}

function säg {
	if [[ -z "$@" ]] ; then
		echo "Säg vadå?" >&2
		return 1
	fi
	if [[ -t 1 ]] ; then
		espeak -v sv --stdout "$@" | paplay
	else
		espeak -v sv --stdout "$@"
	fi
}

# prompt
prompt_dir='%{$fg_no_bold[cyan]%}%~%{$reset_color%}'
prompt_exit='%(?.%{$fg_bold[green]%}OK«%{$reset_color%}.%{$fg_bold[red]%}%?«%{$reset_color%})'
prompt_host='%{$fg_bold[cyan]%}%m%{$reset_color%}'
prompt_user='%{$fg_bold[cyan]%}%n%{$reset_color%}'
prompt_tail='%{$fg_bold[white]%}»%{$reset_color%}'

PROMPT="${prompt_user}@${prompt_host} ${prompt_dir} ${prompt_tail} "
RPROMPT="${prompt_exit}"

unset prompt_dir
unset prompt_exit
unset prompt_host
unset prompt_user
unset prompt_tail
