setopt prompt_subst

_prompt_user='%{$fg_bold[cyan]%}%n%{$reset_color%b%}'
_prompt_host='%{$fg_bold[cyan]%}%m%{$reset_color%b%}'
_prompt_dir='%{$fg[cyan]%}%~%{$reset_color%}'
_prompt_errorcode='[%{$fg[cyan]%}%?%{$reset_color%b%}]'

PROMPT="[${_prompt_user}@${_prompt_host}:${_prompt_dir}]%# "
RPROMPT="${_prompt_errorcode}"
