# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh_my_zsh"

# Set name of the theme to load if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="af-magic"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(
	git
	docker
	zsh-autosuggestions
	osx
	autojump
	brew
	zsh-syntax-highlighting
	zsh-autosuggestions
)

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line

# use vi mode
bindkey -v 



# Remove mode switching delay.
KEYTIMEOUT=5

ZSH_MODE=""
# Change cursor shape for different vi modes.

zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt.
preexec() {
   echo -ne '\e[5 q'
}

function zle-line-init zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
		[[ $1 = 'block' ]]; then
		echo -ne '\e[1 q'
		ZSH_MODE="--NORMAL-- "

	elif [[ ${KEYMAP} == main ]] ||
		[[ ${KEYMAP} == viins ]] ||
		[[ ${KEYMAP} = '' ]] ||
		[[ $1 = 'beam' ]]; then
		echo -ne '\e[5 q'
		ZSH_MODE=""
	fi

	#RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
	#RPS2=$RPS1
	zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

local ret_status="%(?:%{$fg_bold[green]%}➜:%{$fg_bold[red]%}➜)"
PROMPT='$ZSH_MODE%{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info) ${ret_status} %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"







source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

export SHELL="$(which zsh)"

source $HOME/.profile

bindkey -v 
