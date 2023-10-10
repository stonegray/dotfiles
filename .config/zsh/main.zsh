ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"


zmodload zsh/zprof 

#set -e 

if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
	print "\nAutomagically configuring zinit...\n\n"
	source "${ZINIT_HOME}/zinit.zsh"
	zinit self-update
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit load zsh-users/zsh-completions

# prompt
source ~/.config/zsh/prompt.zsh

# Typing 
zinit load zsh-users/zsh-autosuggestions
zinit light "IngoMeyer441/zsh-easy-motion"
zinit light redxtech/zsh-not-vim
zinit load zpm-zsh/colorize




autoload -Uz compinit && compinit

zinit load zsh-users/zsh-syntax-highlighting
zinit load zsh-users/zsh-history-substring-search

source ~/.config/zsh/plugin/*.zsh
source ~/.config/zsh/include/*.zsh
source ~/.config/zsh/include/theme.zsh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

export EDITOR=`which nvim`
export VISUAL=`which nvim`

setopt inc_append_history
