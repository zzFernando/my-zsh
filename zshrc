export ZSH="/home/matrix/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    aws
    terraform
    docker
    zsh-syntax-highlighting
    zsh-autosuggestions
    fzf
)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias update="sudo apt -y update ; sudo apt -y full-upgrade ; sudo apt -y autoremove ; sudo apt -y autoclean"
