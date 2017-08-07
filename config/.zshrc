# options
setopt always_to_end
setopt auto_cd
setopt auto_pushd
setopt cdable_vars
unsetopt check_jobs
setopt combining_chars
setopt complete_in_word
setopt extended_glob
unsetopt flow_control
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
unsetopt hup
setopt interactive_comments
setopt long_list_jobs
setopt prompt_subst
setopt pushd_minus
setopt pushd_to_home
setopt share_history

# load things
autoload -Uz colors
colors
autoload -Uz compinit
compinit
zmodload zsh/complist
source /usr/share/doc/pkgfile/command-not-found.zsh

# define and declare widgets
autoload -Uz up-line-or-beginning-search
zle -N up-line-or-beginning-search

autoload -Uz down-line-or-beginning-search
zle -N down-line-or-beginning-search

function intelligent-return-key {
	if [[ ${#BUFFER} -eq 0 ]] ; then
		echo
		pwd
		if [[ $(ls -1 | wc -l) -gt $((LINES - 3)) ]] ; then
			echo "Too many entries to list."
		else
			ls --color=auto --group-directories-first -FhoN
		fi
		zle redisplay
	else
		zle accept-line
	fi
}
zle -N intelligent-return-key

# syntax highlighting has to be loaded after widgets are declared
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# keybindings
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^M' intelligent-return-key

# freeze tty
ttyctl -f

# completion
zstyle ':completion:*' cache-path "$HOME/.zsh_cache"
zstyle ':completion:*' list-colors '=*=35' 'ma=37;45'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache true

# syntax highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]='none'
ZSH_HIGHLIGHT_STYLES[arg0]='none'
ZSH_HIGHLIGHT_STYLES[assign]='none'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[builtin]='none'
ZSH_HIGHLIGHT_STYLES[command]='none'
ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='none'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[function]='none'
ZSH_HIGHLIGHT_STYLES[globbing]='none'
ZSH_HIGHLIGHT_STYLES[hashed-command]='none'
ZSH_HIGHLIGHT_STYLES[history-expansion]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[precommand]='none'
ZSH_HIGHLIGHT_STYLES[reserved-word]='none'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='none'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='none'
ZSH_HIGHLIGHT_STYLES[unknown-token]='none'

ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[comment]='fg=black,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=cyan'

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# pager
export PAGER='less'
export LESS='-FKMRX'

# editor and browser
if [[ -n "$SSH_CONNECTION" || -z "$DISPLAY" ]] ; then
	export EDITOR='nano'
	export BROWSER='w3m'
else
	export EDITOR='gedit'
	export BROWSER='firefox'
fi

# functions and aliases
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

alias sudo='sudo ' # this makes aliases work when run with sudo

alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias d='dirs -lv'
alias p='pwd'

alias j='jobs -l'
alias jr='jobs -lr'
alias js='jobs -ls'

alias k='kill'
alias c='kill -CONT'
alias s='kill -TSTP'

alias pc='pacaur'
alias pcc='pacaur -Scc'
alias pci='pacaur -S'
alias pcr='pacaur -Rsc'
alias pcs='pacaur -Ss'
alias pcu='pacaur -Syu'
alias pcud='pacaur -Syu --devel'

alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gcl='git clone --recursive'
alias gcm='git commit -vm'
alias gf='git fetch'
alias gl='git pull'
alias gp='git push'
alias gst='git status'

alias emergency='systemctl emergency'
alias hibernate='systemctl hibernate'
alias reboot='systemctl reboot'
alias shutdown='systemctl poweroff'
alias suspend='systemctl suspend'

alias ls='ls --color=auto --group-directories-first'
alias l='ls -FhoN'
alias la='ls -AFhoN'
alias ldot='ls -dFhoN .*'

alias cp='cp -ri'
alias mv='mv -i'
alias rm='rm -ri'
alias srm='srm -ri'

alias grep='grep --color=auto -n'
alias -g G='| grep'
alias -g L='| less'

alias cmd="wine cmd"
alias history='fc -il 1 | less +G'
alias manh='man -H'
alias pkgfiles='pkgfile -l'
alias su='sudo -i'
alias x='exit'

# prompt
prompt_dir='%{$fg_no_bold[cyan]%}%1d%{$reset_color%}'
prompt_exit='(%(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})%?%{$reset_color%}%)'
prompt_host='%{$fg_bold[cyan]%}%m%{$reset_color%}'
prompt_user='%{$fg_bold[cyan]%}%n%{$reset_color%}'
prompt_tail='%{$reset_color%}Σ'

PROMPT="${prompt_user}@${prompt_host} ${prompt_dir} ${prompt_tail} "
RPROMPT="${prompt_exit}"

unset prompt_dir
unset prompt_exit
unset prompt_host
unset prompt_user
unset prompt_tail
