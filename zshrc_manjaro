export ZSH="/home/fernando/.oh-my-zsh"

ZSH_THEME="robbyrussell"

auto-update (in days).

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

[ -d /home/linuxbrew/.linuxbrew ] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
