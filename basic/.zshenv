export EDITOR=vim
export VISUAL=$EDITOR

alias ls='ls -v --color'
alias sudovim='sudo -E vim'
alias tbin='nc termbin.com 9999'
alias e='chmod 755'
alias lst='echo $history[$(expr $HISTCMD - 1)]'
# dot <packages...> to stow
# dot -D <packages...> to unstow
alias dot='stow -d $HOME/.dotfiles -t $HOME'
