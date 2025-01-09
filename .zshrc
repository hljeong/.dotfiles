set -o ignoreeof

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=''
HYPHEN_INSENSITIVE='true'
zstyle ':omz:update' mode reminder
zstyle ':omz:*' aliases no
source $ZSH/oh-my-zsh.sh

eval "$(oh-my-posh init zsh --config ~/.agnoster.omp.json)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_COMPLETION_TRIGGER='...'

eval "$(dircolors -b $HOME/.dircolors)"

eval "$(zoxide init zsh)"
alias cd=z
alias cdi=zi
alias ls='ls --color=auto'

if command -v tmux &>/dev/null &&
   [ -n "$PS1" ] &&
   [[ ! "$TERM" =~ screen ]] &&
   [[ ! "$TERM" =~ tmux ]] &&
   [ -z "$TMUX" ] &&
   [[ ! "$TERM_PROGRAM" == vscode ]]; then
  tmux attach || tmux
fi


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/mphillotry/.opam/opam-init/init.zsh' ]] || source '/home/mphillotry/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

alias vim='nvim'
alias gr='rg'

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

alias python='python3'
