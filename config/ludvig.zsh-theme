setopt prompt_subst

_prompt_user='%(?.%{$fg_bold[cyan]%}%n%{$reset_color%b%}.%{$fg_bold[red]%}%n%{$reset_color%b%})'
_prompt_host='%(?.%{$fg_bold[cyan]%}%m%{$reset_color%b%}.%{$fg_bold[red]%}%m%{$reset_color%b%})'
_prompt_dir='%(?.%{$fg[cyan]%}%~%{$reset_color%}.%{$fg[red]%}%~%{$reset_color%})'

PROMPT="[${_prompt_user}@${_prompt_host}:${_prompt_dir}] %# "
unset RPROMPT
