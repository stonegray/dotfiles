# Stone's profile.
# shellcheck disable=SC2039
# shellcheck disable=SC2034

# See individual shell configurations (bashrc, zshrc etc) for more info.

# Logger:
log() {
	tput cuu 1 && tput el
	echo ".profile:  $1"
}
tput cuu 1 && tput el

# Uncomment to show commands as run
#set -o xtrace


# Enviroment
export EDITOR="`which vim`"

# Default to bash-like wildcard behaviour
unsetopt no_match

# Set $ZSH
export ZSH=~/.oh_my_zsh
export PATH=$PATH:~/.npm-packages/bin/


# History
###############################################################################

# Don't create duplicate entries
# Implicit ignoredups, could use ignoreboth if not erasing.
export HISTCONTROL=ignorespace:erasedups

# Don't save commands without effect:
export HISTIGNORE="ls*:cd"

# Increase size
export HISTSIZE=100000
export HISTFILESIZE=100000



# Append to history instead of overwriting it
if [ -n "$ZSH_VERSION" ]; then
	# ZSH:
	setopt APPEND_HISTORY
	setopt setopt inc_append_history
	setopt share_history
elif [ -n "$BASH_VERSION" ]; then
	# Bash:
	shopt -s histappend
else
	log "Unknown shell, skipping changing history mode"
fi



# SSH
###############################################################################


# If we're on macOS, use system ssh-add to access keychain.
if [[ "$OSTYPE" == "darwin"* ]]; then
	SSH_ADD="/usr/bin/ssh-add"
else 
	SSH_ADD="$(which ssh-add)"
fi

# Set smart card host:
if [ -f "/usr/lib/ssh-keychain.dylib" ] ; then
	PKCS11Provider=/usr/lib/ssh-keychain.dylib
fi

# Start an agent if one isn't available:
if [ -n "${SSH_AUTH_SOCK+set}" ] ; then
	log "ssh: $SSH_AUTH_SOCK"
else
	log "No available agent socket, creating..."
	eval "$(ssh-agent -s)" >> /dev/null
fi


# Always require confirmation of keys, be quiet.
SSHARGS="qc"

# Check if we already have keys loaded:

if ssh-add -L >> /dev/null ; then

	log "$(ssh-add -L | wc -l | sed -e 's/^[ \t]*//') keys loaded"
else
	# If we're on macOS, give ssh-add the following args:
	# -K	Adds the key to the user's Keychain
	# -A	Adds keys already in the user's Keychain
	if [[ "$OSTYPE" == "darwin"* ]]; then
		SSHARGS+="K"
	fi

	/usr/bin/ssh-add -A
	# For each key, run ssh-add.
	grep -Rl "PRIVATE" ~/.ssh/ | xargs /usr/bin/ssh-add -K 
fi


# ALiases
###############################################################################
# Fix scrolling bug in weechat by not using xterm.
alias weechat="TERM=screen-256color-bce weechat"

# Hide node_modules in tree
alias tree="tree -I \"node_modules|node_modules.nosync\""

# colorify and humanize LS
alias ls="ls -GFh"

# run last command through less
alias ll="!! | less"

# Task
alias ta="task add"
alias tl="task list"
alias t="task"

# New Aliases

# Use brew prefix for tags on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
	alias ctags="`brew --prefix`/bin/ctags"
fi

# Magical tmate fixer:
alias tmate2="~/.tmate2"

#Theme
##########

# Less Colors for Man Pages 
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking 
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold 
export LESS_TERMCAP_me=$'\E[0m'           # end mode 
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode 
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box 
export LESS_TERMCAP_ue=$'\E[0m'           # end underline 
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline


# Autojump
#################
if [ -f /usr/local/etc/profile.d/autojump.sh ]; then
	true
	source /usr/local/etc/profile.d/autojump.sh # This loads autojump
else
	echo "$LOGPREFIX Autojump is not installed, skipping"
fi

# NVM
#################
if [ -d "$HOME/.nvm" ]; then
	if which nvm >> /dev/null; then
		log "skipping nvm..."
	else
		log "waiting for nvm..."
		export NVM_DIR="$HOME/.nvm"
		[ -s "$NVM_DIR/nvm.sh" ] && . $NVM_DIR/nvm.sh 
		[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	fi
else
	echo "$LOGPREFIX NVM is not installed, skipping."

fi


# Yarn
#################
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


# Google Cloud SDK.
#################
if [ -f '/Users/stonegray/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/stonegray/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -n "$ZSH_VERSION" ]; then
	if [ -f '/Users/stonegray/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/stonegray/google-cloud-sdk/completion.zsh.inc'; fi
fi

log "$LINENO/$LINENO shell startup tasks done"


export PATH="/usr/local/opt/ruby/bin:$PATH"
alias sv="open -b org.sonicvisualiser.SonicVisualiser"




# Terminal
############################

# Fix laggy command mode switching in ZSH
export KEYTIMEOUT=1
bindkey -M viins 'jk' vi-cmd-mode



# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
