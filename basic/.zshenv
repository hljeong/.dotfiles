export PATH=$HOME/.bin:$HOME/.bin/facade:$HOME/.local/bin:$PATH
export EDITOR=vim
export VISUAL=$EDITOR

alias ls='ls -v --color'
alias sudovim='sudo -E vim'
alias tbin='nc termbin.com 9999'
alias e='chmod 755'
# dot <packages...> to stow
# dot -D <packages...> to unstow
alias dot='stow -d $HOME/.dotfiles -t $HOME'
