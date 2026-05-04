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
alias ll='ls -lh'
alias la='ls -a'
alias lla='ll -a'

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

cls() {
   for i in $(seq 100); do
      echo
   done
}

here() {
   if [[ -x "./$1" ]]; then
      "./$@"
   else
      echo "error: ./$1 is not an executable in cwd"
      return 1
   fi
}

alias vim='nvim'
alias gr='rg'

git_log_params='--pretty=format:"%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s" --date=short'
alias gs='git status'
alias gaa='git add -A'
alias gd='git diff'
alias gds='git diff --staged'
alias gl="git log $git_log_params"
alias gls="git --no-pager log $git_log_params -n$(($(tput lines) - 1)); echo"
alias gf='git fetch'
alias gco='git checkout'
alias gc='git commit'
alias gca='git commit --amend'
alias gcm='git commit -m'
alias gri='git rebase -i'
alias gp='git push'
alias gpf='git push --force'

alias python='python3'
alias py='python -m IPython'

# reload rc
alias rrc='source ~/.zshrc && echo "reloaded ~/.zshrc"'
# edit rc
alias erc='vim ~/.zshrc'

alias ipc-s='(cd /home/mphillotry/repo/ipc/ipc; waitress-serve --port=9728 server:app)'
alias ipc='python /home/mphillotry/repo/ipc/ipc/client.py'

alias get-font='gsettings get "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:475629ae-b578-4e2d-ba50-6431353ef82a/" font'
alias set-font='gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:475629ae-b578-4e2d-ba50-6431353ef82a/" font '

alias activate='source activate'

run() {
   src=${1:-$(ls -t *.cc | head -n 1)}
   echo "running $src"
   g++-13 -g -std=c++20 $src && (./a.out || echo "returned $?")
   rm -f a.out
}

# opencode
export PATH=/home/mphillotry/.opencode/bin:$PATH
