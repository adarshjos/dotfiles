DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
HOMEBREW_PREFIX := /opt/homebrew
SHELLS := /private/etc/shells
BIN := $(HOMEBREW_PREFIX)/bin
PATH := $(HOMEBREW_PREFIX)/bin:$(DOTFILES_DIR)/bin:/usr/local/bin:/bin:/usr/bin:
export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)
export ACCEPT_EULA=Y
SHELL := /bin/zsh

# Function to check if a command exists
is-executable = $(shell if type $(1) > /dev/null 2>&1; then echo "true"; else echo "false"; fi)

.PHONY: test

macos: sudo core-macos packages link

core-macos: brew bash git

stow-macos: brew
	@if ! command -v stow >/dev/null 2>&1; then \
		brew install stow; \
	else \
		echo "stow is already installed."; \
	fi

sudo:
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

packages: brew-packages cask-apps

link: stow-macos
	@echo "PATH is: $$PATH"
	for FILE in $(shell ls -A zsh); do \
		if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		  	echo "Processing file: $(HOME)/$$FILE"; \
			mv -v $(HOME)/$$FILE $(HOME)/$$FILE.bak; \
		fi; \
	done
	echo "Processing file: $(HOME)/$$FILE"; \
	mkdir -p "$(XDG_CONFIG_HOME)"
	stow -t "$(HOME)" zsh --adopt
	stow -t "$(XDG_CONFIG_HOME)" config --adopt
	mkdir -p $(HOME)/.local/runtime
	chmod 700 $(HOME)/.local/runtime

unlink: stow-macos
	stow --delete -t "$(HOME)" zsh
	stow --delete -t "$(XDG_CONFIG_HOME)" config
	for FILE in $(shell ls -A runcom); do \
		if [ -f $(HOME)/$$FILE.bak ]; then \
			mv -v $(HOME)/$$FILE.bak $(HOME)/$$FILE; \
		fi; \
	done

brew:
	@if [ "$(call is-executable,brew)" = "false" ]; then \
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash; \
	fi

bash: brew
	if ! grep -q bash $(SHELLS); then \
		brew install bash bash-completion@2 pcre && \
		sudo append $(shell which bash) $(SHELLS) && \
		chsh -s $(shell which bash); \
	fi

git: brew
	brew install git git-extras

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile || true

cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true
