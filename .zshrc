# options
set -o ignoreeof

# zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=''
HYPHEN_INSENSITIVE='true'
zstyle ':omz:update' mode reminder
zstyle ':omz:*' aliases no
source $ZSH/oh-my-zsh.sh

# omp
eval "$(oh-my-posh init zsh --config ~/.omp.json)"

# shell
eval "$(dircolors -b $HOME/.dircolors)"
eval "$(zoxide init zsh)"
alias cd=z
alias cdi=zi
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -a'
alias lla='ll -a'

# tmux
if command -v tmux &>/dev/null &&
   [ -n "$PS1" ] &&
   [[ ! "$TERM" =~ screen ]] &&
   [[ ! "$TERM" =~ tmux ]] &&
   [ -z "$TMUX" ] &&
   [[ ! "$TERM_PROGRAM" == vscode ]]; then
  tmux attach || tmux
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_COMPLETION_TRIGGER='...'

# executables
alias vim='nvim'
alias gr='rg'

# git
git_log_params='--pretty=format:"%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s" --date=short'
alias gs='git status'
alias gaa='git add -A'
alias gd='git diff'
alias gl="git log $git_log_params"
alias gls="git --no-pager log $git_log_params -n$(tput lines); echo"
alias gf='git fetch'
alias gc='git commit'
alias gcm='git commit -m'
alias gri='git rebase -i'
alias gp='git push'
alias gpu='git pull'

# python
alias python='python3'
