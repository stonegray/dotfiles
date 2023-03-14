# all hail the evil mode
bindkey -v

# Partial Bash compatibilty
# #########################

# Use C-r as globified, even
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^L' c

# Easy mode changes:
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode

# Restore bash C-a behaviour:
bindkey '^A'				beginning-of-line
