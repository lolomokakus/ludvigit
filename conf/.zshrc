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
autoload -Uz compinit
compinit
zmodload zsh/complist
source /usr/share/doc/pkgfile/command-not-found.zsh

# freeze tty
ttyctl -f

# define and declare widgets
autoload -Uz up-line-or-beginning-search
zle -N up-line-or-beginning-search

autoload -Uz down-line-or-beginning-search
zle -N down-line-or-beginning-search

function omniscient-return-key {
	case $BUFFER in
		\$?*)
			_ork_var="${$(set -- "$BUFFER"; echo "$1")##*\$}"
			echo
			if [[ -v "$_ork_var" ]] ; then
				echo "${(P)_ork_var}"
			else
				echo "(unset)"
			fi
			zle kill-buffer
			zle reset-prompt
			;;
		'')
			echo
			if [[ "$(ls -1U | wc -l)" -gt "$((LINES - 2))" ]] ; then
				echo "Too many entries to list."
			else
				ls --color=auto --group-directories-first -FhoN
			fi
			zle reset-prompt
			;;
		*)
			zle accept-line
			;;
	esac
}
zle -N omniscient-return-key

# keybindings
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search
bindkey "$terminfo[cr]" omniscient-return-key

# completion
zstyle ':completion:*' cache-path "$HOME/.zsh_cache"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" 'ma=37;45'
#zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache true

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# report time after running a command
TIMEFMT='%J (u: %*U; s: %*S; r: %*E)'
REPORTTIME=5

# prompt
PROMPT='%F{magenta}%B%?%f%b %F{cyan}%B%~%f%b %F{white}%B»%f%b '

# functions and aliases
function path {
	if [[ -v 1 ]] ; then
		export PATH="$1"
	fi
	echo "$PATH"
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
alias d='dirs -v'
alias p='pwd'

alias j='jobs -l'
alias jr='jobs -lr'
alias js='jobs -ls'
alias t='time'

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
alias pf='pkgfile'
alias pfl='pkgfile -L'

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

alias cp='cp -fr'
alias rm='rm -r'
alias srm='srm -r'

alias lo='locate -b'
alias udb='updatedb'

alias grep='grep --color=auto -n'
alias -g G='| grep'
alias -g L='| less'

alias beep='setuid-beep'
alias piano='setuid-piano'
alias typewrite='setuid-typewrite'

alias cmd='wine cmd'
alias hd='hexdump -C'
alias history='fc -il 1 | less +G'
alias manh='man -H'
alias p0x='ping -a 0x4c.se'
alias reset='reset && echo -n "\x1b[9;0]\x1b[14;0]\x1b[10;440]\x1b[11;100]"'
alias su='sudo -i'
alias wh='where'
alias x='exit'
