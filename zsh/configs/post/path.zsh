# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH"

# load rbenv if available
if command -v rbenv >/dev/null; then
  eval "$(rbenv init - --no-rehash)"
fi

# load nvm if available
export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"

export -U PATH
