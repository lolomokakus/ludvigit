# my personal collection of aliases

alias sudo='sudo ' # this makes aliases work when run with sudo

alias pci='pacaur -S'
alias pcr='pacaur -Rs'
alias pcu='pacaur -Syu'
alias pcud='pacaur -Syu --devel'
alias pcs='pacaur -Ss'
alias pcns='locate .pacnew .pacsave'

alias shutdown='systemctl poweroff'
alias reboot='systemctl reboot'
alias suspend='systemctl suspend'
alias hibernate='systemctl hibernate'
alias emergency='systemctl emergency'

alias ls='ls --color=auto'
alias l='ls -lFh'
alias la='ls -lAFh'
alias ldot='ls -lFhd .*'
unalias lsa
unalias ll

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
