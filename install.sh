#!/bin/bash

# cd to here
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" || exit

shopt -s nullglob

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

array=()
while IFS= read -r -d $'\0'; do
	array+=("$REPLY")
done < <(
	sh -c 'cd home && find . -type f -print0'
)

echo "linking ${#array[@]} files..."
echo ${array[@]}
for i in "${array[@]}";do
	if [[ -L "~/${i}" ]]
	then
		unlink ~/${i}
	else 
		mkdir -p  ~/.Trash/${i} 2> /dev/null
		mv ~/${i} ~/.Trash/${i} 2> /dev/null
		unlink ~/${i}
	fi
	ln -s $PWD/home/${i} ~/${i}
done






