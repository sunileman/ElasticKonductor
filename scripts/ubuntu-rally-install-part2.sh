#!/bin/bash

# Set environment variables
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

##Check yor pyenv version
pyenv --version

##install pyton 3.8.13
pyenv install 3.8.13
pyenv global 3.8.13


##Install rally
python3 -m pip install --user --upgrade pip
python3 -m pip install --user esrally


##Git clone
git clone https://github.com/elastic/rally-tracks.git