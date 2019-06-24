# export PATH=$HOME/bin:/usr/local/bin:$PATH
echo "Starting.."

# Path to your oh-my-zsh installation.
export ZSH="/Users/stonegray/.oh-my-zsh"

# Set name of the theme to load if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(
	git
	docker
	zsh-autosuggestions
	osx
	autojump
	brew
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

export SHELL="$(which zsh)"
source $HOME/.profile

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
