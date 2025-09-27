# dotfiles

*A set of `vim`, `zsh`, `git`, and `tmux` configuration files.*

## Usage

Set `zsh` as your login shell:

```sh
chsh -s $(which zsh)
```

Clone dotfiles repository:

```sh
git clone https://github.com/wouterw/dotfiles.git ~/.dotfiles
```

Install [stow](https://www.gnu.org/software/stow/):

```sh
# On macOS
brew install stow

# On Arch Linux
sudo pacman -S stow

# On Ubuntu/Debian
sudo apt install stow
```

Install the dotfiles:

```sh
cd ~/.dotfiles && ./install.sh
```
