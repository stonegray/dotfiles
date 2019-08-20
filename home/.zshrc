# export PATH=$HOME/bin:/usr/local/bin:$PATH
echo "Starting.."



# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh_my_zsh"

# Set name of the theme to load if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="af-magic"

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

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

export SHELL="$(which zsh)"

source $HOME/.profile

