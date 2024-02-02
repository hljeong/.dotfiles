export ZSH="$HOME/.oh-my-zsh"
export LC_ALL='C.UTF-8'
ZSH_THEME='custom-agnoster'
HYPHEN_INSENSITIVE='true'
zstyle ':omz:update' mode auto
source $ZSH/oh-my-zsh.sh

eval "$(dircolors -b $HOME/.dircolors)"

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  tmux attach || tmux
fi

TERM=screen-256color
