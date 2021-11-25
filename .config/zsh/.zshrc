# zshrc

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
	print "\nAutomagically configuring zinit...\n\n"
	source "${ZINIT_HOME}/zinit.zsh"
	zinit self-update
fi

autoload -U colors && colors

setopt PROMPT_SUBST

source ~/.config/zsh/stone.zsh-theme

source "${ZINIT_HOME}/zinit.zsh"

# all hail the evil mode
bindkey -v

# Typing 
#zinit load marlonrichert/zsh-autocomplete
zinit load menketechnologies/zsh-expand

# Fun
zinit light redxtech/zsh-not-vim

# omzs imports:
zinit snippet OMZP::node
zinit snippet OMZP::autojump
zinit snippet OMZP::brew

# Theming/color
zinit load zpm-zsh/colorize

# Has to be last?
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
zinit load zsh-users/zsh-syntax-highlighting
