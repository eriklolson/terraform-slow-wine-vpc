# conda config --add channels conda-forge
# conda config --set channel_priority strict

mkdir -p $HOME/micromamba



#Install Micromamba
if ! command -v micromamba &> /dev/null
then
    echo "installing micromamba"
    curl -L micro.mamba.pm/install.sh | bash
    micromamba shell init --shell zsh --root-prefix ~/micromamba
else
    echo "micromamba is already installed"
fi

# Zshrc: Aliases
alias lf='ls -la'
alias ld='~ ls -dl */'
alias h='subl cd ~'
alias zconf='subl ~/.zshrc'
alias sz='r ~/.zshrc'
alias ip='ip -color=auto'
alias ai='sudo apt update -y && sudo apt install -y  -color=auto'
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
echo "alias pir='pip install -r requirements.txt'" >> ~/.zshrc
echo "alias vih='vim .'"  >> ~/.zshrc

echo "alias m=micromamba" >> ~/.zshrc
echo "alias ma='micromamba activate'" >> ~/.zshrc
echo "alias mc='micromamba create --name'" >> ~/.zshrc
echo "alias ml='micromamba env list'" >> ~/.zshrc
echo 'alias uncommit="git reset --soft HEAD^"' >> ~/.zshrc

#Fix conda commands
echo 'alias conda=micromamba' >> ~/.zshrc