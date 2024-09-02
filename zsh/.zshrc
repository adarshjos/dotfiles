# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source_if_exists () {
    if test -r "$1"; then
        source "$1"
    fi
}


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Change the command execution timestamp shown in the history command output.
HIST_STAMPS="dd.mm.yyyy"

# Don't set any aliases from oh-my-zsh and/or plugins - keep the aliases clean
zstyle ':omz:*' aliases no
# oh-my-zsh update behavior
zstyle ':omz:update' mode reminder
zstyle ':omz:update' verbose minimal
zstyle ':omz:update' frequency 14 # days

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(brew direnv asdf fzf zsh-autosuggestions zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Load User configuration, as conditionally linked
for script in $HOME/.zsh_setup.d/*.zsh; do
  [[ ${script:t} != '~'* ]] || continue # ignore files starting with tilde
  source "$script"
done


if type "direnv" > /dev/null; then
    eval "$(direnv hook zsh)"
fi

autoload -U zmv
autoload -U promptinit && promptinit
autoload -U colors && colors
autoload -Uz compinit && compinit

if test -z ${ZSH_HIGHLIGHT_DIR+x}; then
else
    source $ZSH_HIGHLIGHT_DIR/zsh-syntax-highlighting.zsh
fi

precmd() {
    source $HOME/.zsh_setup.d/aliases.zsh
    source $HOME/.zsh_setup.d/paypal_aliases.zsh
}
export PATH="$HOME/bin:$PATH"



# GO EXPORTS ----------------------
export GODEBUG=x509sha1=1
export GOSUMDB="off"
export GO111MODULE="on"
export GOPROXY="https://artifactory.g.devqa.gcp.dev.paypalinc.com/artifactory/go,direct"
export PATH=$(go env GOPATH)/bin:$PATH



# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~$HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/adjoseph/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
