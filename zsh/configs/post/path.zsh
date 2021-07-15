# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH"

# load asdf
[[ -f "$(brew --prefix asdf)/asdf.sh" ]] && source "$(brew --prefix asdf)/asdf.sh"

# load rbenv if available
if command -v rbenv >/dev/null; then
  eval "$(rbenv init - --no-rehash)"
fi

# load yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# load cargo
[[ -f ~/.cargo/env ]] && source ~/.cargo/env

# load vscode
export PATH="$PATH:/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin"

export -U PATH
