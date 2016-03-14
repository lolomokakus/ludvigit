PROMPT='$(_prompt_errno)> '
RPROMPT='%n@%m:%~'

function _prompt_errno() {
  local errno=$?
  if [ ! $errno = 0 ]; then
    echo -n "$errno"
  fi
}
