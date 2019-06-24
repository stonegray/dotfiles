# See also: ~/.profile

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx # I forget how this works

if [ -f $(brew --prefix)/etc/bash_completion ]; then
	source $(brew --prefix)/etc/bash_completion
fi

