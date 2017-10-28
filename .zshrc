#.zshrc -- dependent on 'oh-my-zsh'

# Path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# Visual theme
ZSH_THEME="steeef"

# Plugins
plugins=(battery git vi-mode jsontools)

source $ZSH/oh-my-zsh.sh

# Custom ZSH folder
ZSH_CUSTOM=$HOME/dotfiles/config/zsh/

# Disable terminal freeze
stty -ixon

# Source existing aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Source non-standard machine specific app aliases
if [ -f ~/.app_aliases ]; then
	. ~/.app_aliases
fi

# enable vim mode on command line
# bindkey -v
function zle-line-init zle-keymap-select {
	NORMAL_MODE_INDICATOR="%{$bg_bold[green]%}%{$fg_bold[black]%}-- NORMAL --%{$reset_color%}"
	INSERT_MODE_INDICATOR="%{$bg_bold[yellow]%}%{$fg_bold[black]%}-- INSERT --%{$reset_color%}"

	RPS1="${${KEYMAP/vicmd/$NORMAL_MODE_INDICATOR}/(main|viins)/$INSERT_MODE_INDICATOR}"
	RPS2=$RPS1
	zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# enable additional vim mode functionality
bindkey -a u undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char  #backspace

# Remap escape key to what I normally use in vim
bindkey kj vi-cmd-mode

# Fix <Shift><Tab> not working for going back
bindkey '^[[Z' reverse-menu-complete

zle_highlight=( default:fg=white  )

# Load directory colors
[ -e $HOME/.dircolors  ] && eval $(dircolors -b $HOME/.dircolors) || eval $(dircolors -b)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
export PS1='%{$purple%}%n${PR_RST} in %{$limegreen%}%~${PR_RST} $vcs_info_msg_0_$(virtualenv_info)
%{$orange%}λ %{$reset_color%}%'

# Start up with tmux
tmux
clear # Clear annoying warning
