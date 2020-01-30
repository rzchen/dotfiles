#!/usr/bin/env bash

set -e

if ! command -v stow 2>&1 >&/dev/null; then
  echo 'Installing stow'
  if [ "$(uname)" == "Darwin" ]; then
    echo 'Mac OS X'
    brew install stow
  elif [ "$("(substr $(uname -s) 1 5)")" == "Linux" ]; then
    echo 'Linux'
    sudo apt install stow
  fi
fi

if [[ ! -d ~/dotfiles ]]; then
  git clone git@github.com:Springok/dotfiles.git ~/dotfiles
fi

cd ~/dotfiles

stow --verbose git \
  zsh \
  nvim \
  tmux \
  ruby

exit 0