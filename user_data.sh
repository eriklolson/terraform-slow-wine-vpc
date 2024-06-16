#!/bin/bash
sudo apt update -y
sudo apt install -y

#Install Apt Packages
yes | sudo apt update
for pkg ingit curl tar nginx tree nodejs npm bzip2 zsh; do
    # if ! dpkg -l $pkg &> /dev/null; then
        # echo "Installing $pkg..."
        yes | sudo apt install $pkg
    # else
        # echo "$pkg is already installed"
    # fi
done


sudo systemctl start nginx

# make zsh default shell
chsh -s $(which zsh)
echo $SHELL



#Install Oh-My-Zsh
yes | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"




# Install Miniforge Conda and Mamba
echo "auto_activate_base: true
env_prompt: ({name})
channels:
  - conda-forge
channel_priority: strict" > $HOME/.condarc



curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba


# Install Miniforge-pypy3 (conda and mamba with conda-forge channel)
mkdir -p ~/miniconda3


curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge-pypy3-$(uname)-$(uname -m).sh"
bash Miniforge-pypy3-$(uname)-$(uname -m).sh

