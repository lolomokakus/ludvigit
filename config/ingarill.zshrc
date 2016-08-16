# load things
autoload -U colors && colors
autoload -U compinit && compinit
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

zmodload -i zsh/complist

setopt always_to_end
setopt auto_cd
setopt auto_menu
setopt auto_pushd
setopt cdable_vars
setopt combining_chars
setopt complete_in_word
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt interactive_comments
setopt long_list_jobs
setopt multios
setopt no_flow_control
setopt no_menu_complete
setopt prompt_subst
setopt pushd_ignore_dups
setopt pushd_minus
setopt share_history

# completion
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' rehash true
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path "$HOME/.zsh_cache"

# pkgfile integration
source /usr/share/doc/pkgfile/command-not-found.zsh

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# pager
export PAGER="less"
export LESS="-RFXK"

# editor
if [[ -n "$SSH_CONNECTION" || -z "$DISPLAY" ]] ; then
	export EDITOR='nano'
else
	export EDITOR='atom'
fi

# keybindings
bindkey '\e[A' up-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search

# aliases and functions
alias sudo='sudo ' # this makes aliases work when run with sudo

alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias pc='pacaur'
alias pci='pacaur -S'
alias pcr='pacaur -Rs'
alias pcu='pacaur -Syu'
alias pcud='pacaur -Syu --devel'
alias pcs='pacaur -Ss'

alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcl='git clone --recursive'
alias gcmsg='git commit -v -m'
alias gf='git fetch'
alias gl='git pull'
alias gp='git push'
alias gst='git status'

alias shutdown='systemctl poweroff'
alias reboot='systemctl reboot'
alias suspend='systemctl suspend'
alias hibernate='systemctl hibernate'
alias emergency='systemctl emergency'

alias ls='ls --color=auto --group-directories-first'
alias l='ls -lFh'
alias la='ls -lAFh'
alias ldot='ls -lFhd .*'
alias rm='rm -ri'
alias cp='cp -ri'
alias mv='mv -i'
alias srm='srm -ri'
alias pipes='pipes -t 3'
alias grep='grep --color=auto -n'
alias tty-clock='tty-clock -cC 7'

alias history='fc -il 1'
alias edit='$EDITOR'
alias say='espeak -v en'
alias säg='espeak -v sv'
alias su='sudo -i'
alias x='exit'
alias cmd='wine ~/.wine/drive_c/windows/system32/cmd.exe'
alias cputemp='sensors coretemp-isa-0000'
alias matrix='cmatrix -bC cyan'
alias pkgfiles='pkgfile -l'

if [[ -n "$DISPLAY" ]] ; then
	alias xflogout='xfce4-session-logout --fast --logout'
	alias xfreboot='xfce4-session-logout --fast --reboot'
	alias xfshutdown='xfce4-session-logout --fast --halt'
	alias xfsuspend='xfce4-session-logout --fast --suspend'
	alias xfhibernate='xfce4-session-logout --fast --hibernate'
fi

function open() {
	if [[ -z "$@" ]] ; then
		file="."
	else
		file="$@"
	fi
	nohup xdg-open "$file" &>/dev/null
}

function path() {
	if [[ -z "$@" ]] ; then
		echo $PATH
	else
		export PATH="$@"
	fi
}

# prompt
prompt_dir='%{$fg[cyan]%}%~%{$reset_color%}'
prompt_errorcode='%(?..%{$fg[red]%B%}%?%{$reset_color%b%}|)'
prompt_host='%{$fg[cyan]%B%}%m%{$reset_color%b%}'
prompt_user='%{$fg[cyan]%B%}%n%{$reset_color%b%}'

PROMPT="[${prompt_errorcode}${prompt_user}@${prompt_host}:${prompt_dir}] %# "

unset prompt_dir prompt_errorcode prompt_host prompt_user
