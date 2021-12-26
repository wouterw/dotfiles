# ------------------------------------------------------------------------------
# Color
# ------------------------------------------------------------------------------

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1

# ------------------------------------------------------------------------------
# Options
# ------------------------------------------------------------------------------

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# ------------------------------------------------------------------------------
# Keybindings
# ------------------------------------------------------------------------------

# give us access to ^Q
stty -ixon

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey "^Q" push-line-or-edit
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# ------------------------------------------------------------------------------
# History
# ------------------------------------------------------------------------------

setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# ------------------------------------------------------------------------------
# Editor
# ------------------------------------------------------------------------------

export VISUAL=nvim
export EDITOR=$VISUAL

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------

alias g=git

alias ll="ls -AlFh"
alias ln="ln -v"
alias mkdir="mkdir -p"

alias e="$EDITOR"
alias v="$VISUAL"

alias ...='../..'

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# ------------------------------------------------------------------------------
# Completion
# ------------------------------------------------------------------------------

# Enable case-insensitive autocomplete
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# ------------------------------------------------------------------------------
# Setup PATH
# ------------------------------------------------------------------------------

# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH"

# load asdf
[[ -f "$(brew --prefix asdf)/asdf.sh" ]] && source "$(brew --prefix asdf)/asdf.sh"

# load yarn
PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# load cargo
[[ -f ~/.cargo/env ]] && source ~/.cargo/env

# load vscode
PATH="$PATH:/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin"

# Export PATH
export -U PATH

# ------------------------------------------------------------------------------
# Prompt
# ------------------------------------------------------------------------------

# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo " %{$fg_bold[green]%}$current_branch%{$reset_color%}"
  fi
}

setopt promptsubst

# Allow exported PS1 variable to override default prompt.
if ! env | grep -q '^PS1='; then
  PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%c%{$reset_color%}$(git_prompt_info) λ '
fi

# ------------------------------------------------------------------------------
# Plugins
# ------------------------------------------------------------------------------

# https://github.com/zsh-users/zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# https://github.com/zsh-users/zsh-autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# https://github.com/zsh-users/zsh-history-substring-search
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ------------------------------------------------------------------------------
# Source local configuration
# ------------------------------------------------------------------------------

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
