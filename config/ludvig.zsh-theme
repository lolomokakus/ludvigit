setopt promptsubst

if [[ "$( uname )" = "Linux" ]] ; then
  color=cyan
elif [[ "$( uname )" = "Darwin" ]] ; then
  color=green
else
  color=magenta
fi

_prompt_errorcode='%(?..%{$fg[red]%B%}%?%{$reset_color%b%}|)'
_prompt_user='%{$fg[$color]%B%}%n%{$reset_color%b%}'
_prompt_host='%{$fg[$color]%B%}%m%{$reset_color%b%}'
_prompt_dir='%{$fg[$color]%}%~%{$reset_color%}'

PROMPT="[${_prompt_errorcode}${_prompt_user}@${_prompt_host}:${_prompt_dir}] %# "
RPROMPT=
