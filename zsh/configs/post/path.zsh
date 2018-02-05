# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH"

# load asdf
if [ -d "$HOME/.asdf" ]; then
  . $HOME/.asdf/asdf.sh
  . $HOME/.asdf/completions/asdf.bash
fi

# load rbenv if available
if command -v rbenv >/dev/null; then
  eval "$(rbenv init - --no-rehash)"
fi

# load nvm if available
export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"

# load yarn if available
export PATH="$HOME/.yarn/bin:$PATH"

# load cargo
[[ -f ~/.cargo/env ]] && source ~/.cargo/env

# load vscode
export PATH="$PATH:/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin"

export -U PATH
