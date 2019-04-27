#!/bin/bash

# cd to here
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" || exit

# Files to be linked
array=(
".sshrc"
".bashrc"
".bash_profile"
".zshrc"
".profile"
".vimrc"
".sshrc"
".sshrc.d"
".tmate.conf"
".tmate2"
".tmux.conf.local"
)

# Append file name. Probably a better way of doing this.
array=( "${array[@]/#/$(pwd)/}" )

# Link to $HOME
echo "> linking ${array[@]} into ~"
ln -s ${array[@]} $HOME


ln -s `pwd`/.vim/snips ~/.vim/
ln -s `pwd`/.config/kitty/kitty.conf ~/.config/kitty/
