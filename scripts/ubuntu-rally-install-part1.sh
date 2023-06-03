#!/bin/bash

##Instructions on install esrally on Ubuntu 20
##AMI which preinstalled esrall if you want to skip these steps: ami-0f761f9d67064067f

##setup ssh clone: https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/github-clone-with-ssh-keys
##ssh-keygen -o -t rsa -C “ssh@github.com”
##ssh -T git@github.com


##Install required packages
sudo apt-get -y update; sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev python3-openssl pbzip2 git htop

##get pyenv package
curl https://pyenv.run | bash

##set some variables
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:~/.local/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> ~/.bashrc
exec "$SHELL"
