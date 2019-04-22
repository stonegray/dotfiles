# Stone's profile. 
# shellcheck disable=SC2039
# shellcheck disable=SC2034

# See individual shell configurations (bashrc, zshrc etc) for more info.

printf "Configuring $SHELL..."




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
elif [ -n "$BASH_VERSION" ]; then
	# Bash:
	shopt -s histappend
else
	echo "Unknown shell, skipping changing history mode"
fi




# SSH
###############################################################################

# Set smart card host:
if [ -f "/usr/lib/ssh-keychain.dylib" ] ; then
	 PKCS11Provider=/usr/lib/ssh-keychain.dylib
fi

# Start an agent if one isn't available:
if [ -z "$SSH_AUTH_PID" ] ; then

	# Source ssh agent and hide unless stderr.
	eval "$(ssh-agent -s)" >> /dev/null
fi


# Always require confirmation of keys, be quiet.
SSHARGS="qc"

# If we're on macOS, give ssh-add the following args:
# -K	Adds the key to the user's Keychain
# -A	Adds keys already in the user's Keychain
if [[ "$OSTYPE" == "darwin"* ]]; then
	SSHARGS+="AK" 
fi

# For each key, run ssh-add.
grep -R "PRIVATE" ~/.ssh/ |\
	xargs ssh-add -${SSHARGS} 



# ALiases
###############################################################################
# Fix scrolling bug in weechat by not using xterm.
alias weechat="TERM=screen-256color-bce weechat"

# Hide node_modules in tree
alias tree="tree -I \"node_modules|node_modules_held\""

# colorify and humanize LS
alias ls="ls -GFh"		

# Use sshrc instead of ssh
alias ssh="sshrc"

# New Aliases

# Use brew prefix for tags on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
	alias ctags="`brew --prefix`/bin/ctags"
fi


# Magical tmate fixer:
alias tmate2="~/.tmate2"

# Plugins 
###############################################################################

# Autojump
if [ -f /usr/local/etc/profile.d/autojump.sh ]; then
	source /usr/local/etc/profile.d/autojump.sh # This loads autojump
else
	echo "$LOGPREFIX Autojump is not installed, skipping"
fi


source /usr/local/etc/profile.d/autojump.sh # This loads autojump


# NVM
if [ -d "$HOME/.nvm" ]; then
	export NVM_DIR="$HOME/.nvm"
	[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
	[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
else
	echo "$LOGPREFIX NVM is not installed, skipping."

fi


# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

