local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
local host_status="$USER@${:-%m}"
PROMPT="${ret_status} ${host_status} %{$fg[cyan]%}%~%{$reset_color%} "

