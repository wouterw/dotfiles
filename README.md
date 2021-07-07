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

Install [rcm](https://github.com/thoughtbot/rcm):

```sh
brew install rcm
```

Install the dotfiles:

```sh
env RCRC=$HOME/.dotfiles/rcrc rcup
```
