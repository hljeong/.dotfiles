.RECIPEPREFIX = >

STOW = stow -d "$$HOME/.dotfiles" -t "$$HOME"

basic-deps: 
> bash $$HOME/.dotfiles/install

use: basic-deps
> $(STOW) --restow basic
> touch use

rm: rm-server
> $(STOW) --delete basic 2>/dev/null
> rm -f use

server-deps: basic-deps
> $$HOME/.dotfiles/install-server

use-server: use server-deps
> $(STOW) --restow server
> (crontab -l 2>/dev/null; echo '@reboot zsh -c '\''serve'\') | crontab -
> touch use-server

rm-server: 
> (crontab -l 2>/dev/null | grep -v '@reboot zsh -c '\''serve'\') | crontab -
> $(STOW) --delete server 2>/dev/null
> rm -f use-server

clean: 
> $(STOW) --delete server 2>/dev/null
> $(STOW) --delete basic 2>/dev/null
> rm -f use*

.PHONY: clean \
        rm \
        rm-server

