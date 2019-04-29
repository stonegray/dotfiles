# Stone's profile.
# shellcheck disable=SC2039
# shellcheck disable=SC2034

# See individual shell configurations (bashrc, zshrc etc) for more info.

# Logger:

function log() {
	tput cuu 1 && tput el
	echo ".profile:  $1"
}

tput cuu 1 && tput el

log "starting $SHELL"

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
alias tree="tree -I \"node_modules|node_modules_held\""

# colorify and humanize LS
alias ls="ls -GFh"

# Use sshrc instead of ssh
alias ssh="sshrc"

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

# Correct bad habits
###############################################################################

# Suggest rmtrash when available.
CMD="rmtrash"
if type "$CMD" > /dev/null; then
	alias rm="echo 'Consider using rmtrash instead. Use a backslash to bypass alias.'"
fi

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


# Plugins
###############################################################################


# Found on https://bbs.archlinux.org/viewtopic.php?pid=692072#p692072
extract () {
	if [ -f $1 ] ; then
		case $1 in
			/*.tar.bz2)   tar xvjf $1    ;;
			*.tar.gz)    tar xvzf $1    ;;
			*.tar.xz)    tar xvJf $1    ;;
			*.bz2)       bunzip2 $1     ;;
			*.rar)       unrar x $1     ;;
			*.gz)        gunzip $1      ;;
			*.tar)       tar xvf $1     ;;
			*.tbz2)      tar xvjf $1    ;;
			*.tgz)       tar xvzf $1    ;;
			*.zip)       unzip $1       ;;
			*.Z)         uncompress $1  ;;
			*.7z)        7z x $1        ;;
			*.xz)        unxz $1        ;;
			*.exe)       cabextract $1  ;;
			*)           echo "\`$1': unrecognized file compression" ;;
		esac
	else
		echo "\`$1' is not a valid file"
	fi
}


# Autojump
#################
if [ -f /usr/local/etc/profile.d/autojump.sh ]; then
	source /usr/local/etc/profile.d/autojump.sh # This loads autojump
else
	echo "$LOGPREFIX Autojump is not installed, skipping"
fi



# NVM
#################
if [ -d "$HOME/.nvm" ]; then
	log "waiting for nvm..."
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && . $NVM_DIR/nvm.sh 
	[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
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
if [ -f '/Users/stonegray/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/stonegray/google-cloud-sdk/completion.zsh.inc'; fi

log "$LINENO/$LINENO startup tasks done"


