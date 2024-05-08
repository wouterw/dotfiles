#!/bin/bash

if [ -d "./nvim-macos-arm64" ]; then
  mv ./nvim-macos-arm64 ./nvim-macos-arm64-old
fi

curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
xattr -c ./nvim-macos-arm64.tar.gz
tar xzvf nvim-macos-arm64.tar.gz
sudo ln -s /usr/local/bin/nvim-macos-arm64/bin/nvim /usr/local/bin/nvim

if [ -d "./nvim-macos-arm64" ]; then
  rm -rf ./nvim-macos-arm64-old
fi

echo "Neovim installation complete."
