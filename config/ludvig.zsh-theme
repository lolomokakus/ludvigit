setopt prompt_subst

local user='%{$fg_bold[cyan]%}%n%{$reset_color%b%}'
local host='%{$fg_bold[cyan]%}%m%{$reset_color%b%}'
local pwd='%{$fg[cyan]%}%~%{$reset_color%}'
local return_code='[%{$fg[cyan]%}%?%{$reset_color%b%}]'

PROMPT="[${user}@${host}:${pwd}]%# "
RPROMPT="${return_code}"
