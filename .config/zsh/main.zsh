
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
	print "\nAutomagically configuring zinit...\n\n"
	source "${ZINIT_HOME}/zinit.zsh"
	zinit self-update
fi

source "${ZINIT_HOME}/zinit.zsh"

source ~/.config/zsh/theme.zsh


source ~/.config/zsh/ls_colors

zinit load zsh-users/zsh-completions

autoload -Uz compinit && compinit

# Typing 
zinit load zsh-users/zsh-autosuggestions

# Fun
zinit light redxtech/zsh-not-vim

# Theming/color
zinit load zpm-zsh/colorize

# prompt
source ~/.config/zsh/prompt.zsh

# Has to be last?
zinit load zsh-users/zsh-syntax-highlighting
zinit load zsh-users/zsh-history-substring-search

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

source ~/.config/zsh/keybinds.zsh

