#
# prompt.zsh
# Copyright (C) 2021 stonegray <stonegray@Stones-MBP>
#
# Distributed under terms of the MIT license.
#

setopt PROMPT_SUBST

# VCS
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git

zstyle ':vcs_info:git*' check-for-changes true
zstyle ':vcs_info:git*' check-for-staged-changes true

zstyle ':vcs_info:git*' stagedstr '%F{2}stage%f'
zstyle ':vcs_info:git*' unstagedstr '%F{1}clean%f'

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-fancybranch git-stash git-space git-status

# Set vcs formats. This assumes Git, and might not make any sense for other VCS.
# 0: Status string 
# 1: Humanized path (eg. git:myRepo/my/path)
zstyle ':vcs_info:git*' formats \
	"%{$fg[yellow]%}%b%{$reset_color%}/%{$fg[blue]%}%m%u%c%{$reset_color%}" \
	"%{$reset_color%}%s:%{$fg[blue]%}%r/%S"

zstyle ':vcs_info:git*' actionformats \
	':%F{85}%b%F{85}%u%c%m%f|%F{67}%a%F{15}%f'

local modeFlag

# Copied from, but modified:
# https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
function +vi-git-untracked()
{
	if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
		git status --porcelain | grep -q '^?? ' 2> /dev/null ; then
			# This will show the marker if there are any untracked files in repo.
			# If instead you want to show the marker only if there are untracked
			# files in $PWD, use:
			#[[ -n $(git ls-files --others --exclude-standard) ]] ; then
			hook_com[staged]+='dirty'
	fi
}

function +vi-git-stash()
{
	local -a stashes

	hook_com[misc]=''  # we don't care about patches
	if [[ -s ${hook_com[base]}/.git/refs/stash ]] ; then
		stashes=$(git stash list 2>/dev/null | wc -l)
		hook_com[misc]=' %{$fg[red]%}stash'
	fi
}

function +vi-git-status()
{
	local ahead behind
	local -a gitstatus

	# Exit early in case the worktree is on a detached HEAD
	git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1 || return 0

	local -a ahead_and_behind=($(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null))

	ahead=${ahead_and_behind[1]}
	behind=${ahead_and_behind[2]}

	(( $ahead )) && gitstatus+=( "+${ahead}" )
	(( $behind )) && gitstatus+=( "-${behind}" )

	hook_com[misc]+=${(j:/:)gitstatus}
}

function update-prompt-string ()
{
	local displayPath gitInfoString

	# If we're in a VCS tracked repo, use a git: path instead of 
	# the actual PWD. Otherwise, use the builtin %~
	if [[ -z ${vcs_info_msg_1_} ]]; then
		displayPath="%~/"
		gitInfoString=""
	else
		displayPath="${vcs_info_msg_1_}"
		# Make sure you keep the space here:
		gitInfoString="%{$reset_color%} (${vcs_info_msg_0_})"
	fi

	PROMPT="%{$fg[yellow]%}> %{$reset_color%}%{$fg[blue]%}%n ${displayPath}${gitInfoString} (${modeFlagString}) » "
}

# Hooks:

function zle-keymap-select ()
{
	case $KEYMAP in
		vicmd) 
			print -rn -- $terminfo[cvvis] # block cursor
			modeFlagString="normal"
			;;
		viins|main) 
			print -rn -- $terminfo[cnorm] # less visible cursor
			modeFlagString="insert"
			;;
	esac

	update-prompt-string
	zle reset-prompt
}

zle -N zle-keymap-select

# On initialization, trigger a check of the modeFlagString
function zle-line-init ()
{
	zle-keymap-select
}

zle -N zle-line-init


precmd()
{
	vcs_info

	#PS1="${ret_status} ${vcs_info_msg_0_} ${host_status} %{$fg[cyan]%}%~%{$reset_color%}"

	update-prompt-string
}


