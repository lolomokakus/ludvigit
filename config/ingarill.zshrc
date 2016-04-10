# Path to your oh-my-zsh installation.
export ZSH=/slow/ludvig/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="ludvig"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=( command-not-found git ludvig-aliases sshbeep )

source $ZSH/oh-my-zsh.sh

# Preferred editor
if [[ -n "$SSH_CONNECTION" || -z "$DISPLAY" ]] ; then
	export EDITOR='nano'
else
	export EDITOR='atom'
fi

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"
