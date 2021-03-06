#!/bin/bash

# cd to here
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" || exit

# Find all direcotories, create them
array=()
while IFS= read -r -d $'\0'; do
	array+=("$REPLY")
done < <(
	sh -c 'cd home && find . -type d -print0'
)

echo "creating ${#array[@]} directories..."
echo ${array[@]}
( cd ~ && mkdir -p ${array[@]} )


# Find all files, symlink them
echo "Finding files..."
array=()
while IFS= read -r -d $'\0'; do
	array+=("$REPLY")
done < <(
	sh -c 'cd home && find . -type f -print0'
)

echo "linking ${#array[@]} files..."
echo ${array[@]}
for i in "${array[@]}";do

	# For each file
	if [[ -L "~/${i}" ]]
	then
		# If it's a symlink, unlink it.
		unlink -rf ~/${i}
	else 
		# Otherwise, prepare the trash, and trash it.
		mkdir -p  ~/.Trash/${i} 2> /dev/null
		rm -rf ~/.Trash/${i}
		mv ~/${i} ~/.Trash/${i} 2> /dev/null
	fi

	# Finally, link it:
	ln -s $PWD/home/${i} ~/${i}
done

# Manual link for tmux:
ln -s -f ~/.tmux/.tmux.conf ~


git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
