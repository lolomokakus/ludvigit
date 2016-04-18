# autoloads and setopts
autoload -U colors && colors
autoload -U compinit && compinit

setopt always_to_end
setopt auto_cd
setopt auto_menu
setopt auto_pushd
setopt cdable_vars
setopt complete_aliases
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
setopt prompt_subst
setopt pushd_ignore_dups
setopt pushd_minus
setopt share_history

unsetopt menu_complete

# completion
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path "$HOME/.zsh_cache"

# pkgfile integration
[[ -e /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# pager
export PAGER="less"
export LESS="-R"

# editor
if [[ -n "$SSH_CONNECTION" || -z "$DISPLAY" ]] ; then
	export EDITOR='nano'
else
	export EDITOR='atom'
fi

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

alias pu='pushd'
alias po='popd'

alias pc='pacaur'
alias pci='pacaur -S'
alias pcr='pacaur -Rs'
alias pcu='pacaur -Syu'
alias pcud='pacaur -Syu --devel'
alias pcs='pacaur -Ss'
alias pcns='locate .pacnew .pacsave'

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

alias ls='ls --color=auto'
alias l='ls -lFh'
alias la='ls -lAFh'
alias ldot='ls -lFhd .*'

alias history='fc -il 1'
alias edit='$EDITOR'
alias sudoedit='sudo $EDITOR'
alias say='espeak -v en'
alias säg='espeak -v sv'
alias path='echo $PATH'
alias x='exit'
alias cmd='wine ~/.wine/drive_c/windows/system32/cmd.exe'
alias cputemp='sensors coretemp-isa-0000'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias srm='srm -d'
alias pipes='pipes -t 3'
alias grep='grep --color=auto'

function open() {
	nohup xdg-open "$@" &>/dev/null
}

function start() {
	nohup $@ &>/dev/null
}

# prompt
_prompt_errorcode='%(?..%{$fg[red]%B%}%?%{$reset_color%b%}|)'
_prompt_user='%{$fg[cyan]%B%}%n%{$reset_color%b%}'
_prompt_host='%{$fg[cyan]%B%}%m%{$reset_color%b%}'
_prompt_dir='%{$fg[cyan]%}%~%{$reset_color%}'

PROMPT="[${_prompt_errorcode}${_prompt_user}@${_prompt_host}:${_prompt_dir}] %# "
RPROMPT=

# beep on ssh login
if [[ -n "$(command -v beep)" && -n "$SSH_CONNECTION" && ! -x "$HOME/.quickly_and_quietly" ]] ; then
	beep -f 261.63 -l 100
	beep -f 392 -l 400
fi
