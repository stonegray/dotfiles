# Bash
###############################################################################

# This file is only used by Bash. See ./.profile for generic shell changes.

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx # I forget how this works

if [ -f $(brew --prefix)/etc/bash_completion ]; then
	source $(brew --prefix)/etc/bash_completion
fi
