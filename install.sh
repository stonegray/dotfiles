#!/bin/bash

# cd to here
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" || exit

# Files to be linked
array=( 
	".sshrc" 
	".vimrc" 
	".sshrc.d"
       	".tmate.conf" 
	".tmux.conf.local" 
)
array=( "${array[@]/#/$(pwd)/}" )

# Link to $HOME
echo "> linking ${array[@]} into ~"


# Link if we can, otherwise show an error.
ln -s ${array[@]} $HOME

