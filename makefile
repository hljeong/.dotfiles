.RECIPEPREFIX = >

STOW = stow -d "$$HOME/.dotfiles" -t "$$HOME"

deps: 
> bash $$HOME/.dotfiles/install

use: deps
> $(STOW) --restow basic
> touch use

rm: rm-server
> $(STOW) --delete basic 2>/dev/null
> rm -f use

server-deps: deps
> $$HOME/.dotfiles/install-server

use-server: use server-deps
> $(STOW) --restow server
> (crontab -l 2>/dev/null; echo '@reboot zsh -c '\''serve'\') | crontab -
> touch use-server

rm-server: 
> (crontab -l 2>/dev/null | grep -v '@reboot zsh -c '\''serve'\') | crontab -
> $(STOW) --delete server 2>/dev/null
> rm -f use-server

client-deps: deps
> $$HOME/.dotfiles/install-client

use-client: use client-deps
> $(STOW) --restow client
> touch use-client

rm-client: 
> $(STOW) --delete client 2>/dev/null
> rm -f use-client

clean: 
> $(STOW) --delete client 2>/dev/null
> $(STOW) --delete server 2>/dev/null
> $(STOW) --delete basic 2>/dev/null
> rm -f use*

.PHONY: clean \
        rm \
        rm-server \
        rm-client

