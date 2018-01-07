# Inställingar
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

# Läs in saker
autoload -Uz compinit
compinit
zmodload zsh/complist
source /usr/share/doc/pkgfile/command-not-found.zsh

# Frys terminalen
ttyctl -f

# Definiera widgetar
autoload -Uz up-line-or-beginning-search
zle -N up-line-or-beginning-search

autoload -Uz down-line-or-beginning-search
zle -N down-line-or-beginning-search

function omniscient-return-key {
	case $BUFFER in
		\$?*)
			local _ork_var="${$(set -- "$BUFFER"; echo "$1")##*\$}"
			echo
			if [[ -v "$_ork_var" ]] ; then
				echo "${(P)_ork_var}"
			else
				echo "(inte definierad)"
			fi
			zle kill-buffer
			zle reset-prompt
			;;
		'')
			echo
			if [[ "$(ls -1U | wc -l)" -gt "$((LINES - 2))" ]] ; then
				echo "För många objekt för att visa."
			else
				ls -FhoN --color=auto --group-directories-first
			fi
			zle reset-prompt
			;;
		*)
			zle accept-line
			;;
	esac
}
zle -N omniscient-return-key

# Tangentbordsgenvägar
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[OA" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey "$terminfo[cr]" omniscient-return-key
bindkey "^M" omniscient-return-key

# Automatisk komplettering
zstyle ':completion:*' cache-path "$HOME/.zsh_cache"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" 'ma=37;45'
#zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache true

# Historik
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# Visa hur lång tid program tog efter att de avslutats
TIMEFMT='%J (A: %*U; S: %*S; V: %*E)'
REPORTTIME=5

# Prompten
PROMPT='%F{magenta}%B%(?.☺.%?)%f%b %F{cyan}%B%~%f%b %F{white}%B»%f%b '

# Funktioner och alias
function path {
	if [[ -v 1 ]] ; then
		export PATH="$1"
	else
		echo "$PATH"
	fi
}

alias sd='sudo ' # Krävs för att alias ska funka med sudo
alias su='sudo -i'

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

alias b='bb-wrapper --aur --build-dir /tmp/bauerbill'
alias bc='bb-wrapper --aur --build-dir /tmp/bauerbill -Scc'
alias bi='bb-wrapper --aur --build-dir /tmp/bauerbill -S'
alias br='bb-wrapper --aur --build-dir /tmp/bauerbill -Rsc'
alias bs='bb-wrapper --aur --build-dir /tmp/bauerbill -Ss'
alias bu='bb-wrapper --aur --build-dir /tmp/bauerbill -Syu'
alias bud='bb-wrapper --aur --build-dir /tmp/bauerbill --build-vcs -Syu'
alias pf='pkgfile'
alias pfl='pkgfile -l'

alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gc='git clone --recursive'
alias gm='git commit -vm'
alias gf='git fetch'
alias gl='git pull'
alias gp='git push'
alias gr='git rm'
alias gs='git status'

alias um='udisksctl mount --block-device'
alias uu='udisksctl unmount --block-device'

alias emergency='systemctl emergency'
alias hibernate='systemctl hibernate'
alias reboot='systemctl reboot'
alias shutdown='systemctl poweroff'
alias suspend='systemctl suspend'

alias ls='ls --color=auto'
alias l='ls -FhoN --group-directories-first'
alias la='ls -AFhoN --group-directories-first'
alias ldot='ls -dFhoN --group-directories-first .*'

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
alias wh='where'
