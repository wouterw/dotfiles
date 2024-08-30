#!/bin/bash

if [ -d "/usr/local/bin/nvim-macos-arm64" ]; then
  mv /usr/local/bin/nvim-macos-arm64 /usr/local/bin/nvim-macos-arm64-old
fi

curl -LO -o /usr/local/bin/nvim-macos-arm64.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
xattr -c /usr/local/bin/nvim-macos-arm64.tar.gz
tar xzvf /usr/local/bin/nvim-macos-arm64.tar.gz

ln -s /usr/local/bin/nvim-macos-arm64/bin/nvim /usr/local/bin/nvim

if [ -d "./nvim-macos-arm64" ]; then rm -rf ./nvim-macos-arm64-old; fi
if [ -d "./nvim-macos-arm64.tar.gz" ]; then rm ./nvim-macos-arm64.tar.gz; fi

echo "Neovim installation complete."
