export PATH="$HOME/.local/bin:$HOME/.bin:/opt/nvim-linux64/bin:$PATH"
export EDITOR=nvim
export VISUAL=$EDITOR

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # this loads nvm

export FZF_DEFAULT_OPTS='--color=bg+:#63364d,gutter:-1 --ansi --layout=reverse --height=40% --bind ctrl-u:half-page-up,ctrl-d:half-page-down'
export FZF_DEFAULT_COMMAND="fd --type f --hidden --color=always ."
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
