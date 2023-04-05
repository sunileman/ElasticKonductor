#!/bin/bash
#This script was built on  Feb 2, 2023.  The versions of the client may not be updated.  Therefore verify and update client version



##install terraform & git
sudo apt-get update -y && sudo apt-get install -y gnupg software-properties-common unzip git apt-transport-https ca-certificates


wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install terraform

##install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.9/2023-01-11/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

##install azure cli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

##
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-cli
##gcloud init to sign in

##installing kubectl
##releases snap info kubectl
sudo apt update
sudo apt install snapd
sudo snap install kubectl --channel=1.24/stable --classic
sudo snap install helm --classic


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

##Check yor pyenv version
pyenv --version

##install pyton 3.8.13
pyenv install 3.8.13
pyenv global 3.8.13


##Install rally
python3 -m pip install --user --upgrade pip
python3 -m pip install --user python-hcl2
python3 -m pip install --user boto3
python3 -m pip install --user argparse