#!/bin/bash

set -e

DOTFILES_DIR="$HOME/.dotfiles"

echo "Installing dotfiles with stow..."

# Ensure we're in the dotfiles directory
cd "$DOTFILES_DIR"

# List of packages to stow
packages=(
    git
    zsh
    tmux
    ruby
    irb
    aerospace
    ghostty
    kitty
    nvim
)

# Stow each package
for package in "${packages[@]}"; do
    echo "Stowing $package..."
    stow -v "$package"
done

echo "Dotfiles installed successfully!"
echo ""
echo "Don't forget to:"
echo "1. Set zsh as your login shell: chsh -s \$(which zsh)"
echo "2. Source your new shell configuration or restart your terminal"
