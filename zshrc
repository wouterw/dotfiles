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

HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt INC_APPEND_HISTORY     # Immediately append to history file.
setopt EXTENDED_HISTORY       # Record timestamp in history.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS       # Dont record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_SPACE      # Dont record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS      # Dont write duplicate entries in the history file.
setopt SHARE_HISTORY          # Share history between all sessions.
unsetopt HIST_VERIFY          # Execute commands using history (e.g.: using !$) immediately

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

# Add completions installed through Homebrew packages
# See: https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null; then
  FPATH=/usr/local/share/zsh/site-functions:$FPATH
fi

# Speed up completion init, see: https://gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# unsetopt menucomplete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end
setopt auto_pushd

# Enable case-insensitive autocomplete
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# kubectl autocomplete
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
alias k=kubectl

# ------------------------------------------------------------------------------
# Setup PATH
# ------------------------------------------------------------------------------

# load homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# load asdf (git)
. "$HOME/.asdf/asdf.sh"

# load cargo
[[ -f ~/.cargo/env ]] && source ~/.cargo/env

# load vscode
PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Export PATH
export -U PATH

# ------------------------------------------------------------------------------
# Prompt
# ------------------------------------------------------------------------------

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
if [[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# https://github.com/zsh-users/zsh-autosuggestions
if [[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# https://github.com/zsh-users/zsh-history-substring-search
if [[ -f /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
  source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi

# ------------------------------------------------------------------------------
# Source local configuration
# ------------------------------------------------------------------------------

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
