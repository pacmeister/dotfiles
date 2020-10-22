#!/usr/bin/env zsh
autoload -Uz compinit; compinit
autoload -Uz colors; colors
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search

setopt COMPLETE_ALIASES
setopt PROMPT_SUBST

git_prompt(){
  echo -n "%F{cyan}"$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/*\(.*\)/\1/')
  if test ! -z "$(git status -s 2>/dev/null)"; then echo " %F{magenta}*"; fi
}

PROMPT='%F{cyan}%# %F{reset}'
RPROMPT='$(git_prompt)%F{244} %F{reset}'

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' completer \
    _complete _correct _complete:foo
zstyle ':completion:*:complete:*:*:*' matcher-list \
    '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:foo:*:*:*' matcher-list \
    'm:{a-zA-Z}={A-Za-z} r:|[-_./]=* r:|=*'
zstyle ':completion:*' rehash true

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -e
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey "^[[3~" delete-char

export PATH=~/store/bin:$PATH
export VISUAL=nvim
export EDITOR=nvim
export HISTFILE=~/.histfile
export SAVEHIST=1111
export HISTSIZE=1111
#export GTK_USE_PORTAL=1
export PLASMA_USE_QT_SCALING=1
#export TERM=xterm-256color
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'

unset SSH_ASKPASS

map(){ for i in $(<&0); do $@ $i; done }
dd(){ sudo dd if=$1 of=$2 bs=1M status=progress oflag=sync }

alias vi="vim"
alias find="du -a | awk '{print \$2}' | grep"
alias cp="rsync -P"
alias cd="pushd > /dev/null"
alias dirs="dirs -v"
alias ls="exa"
alias la="exa -a"
alias ll="exa -ahl -snew"
alias tree="exa -T"
alias upgrade="sudo cp ~/git/dotfiles/configuration.nix /etc/nixos && sudo nix-channel --update && sudo nix-collect-garbage -d && sudo nixos-rebuild switch --upgrade"
alias clear="clear && tmux clear-history"
#alias reboot="systemctl reboot"
alias acme="9 acme -f ~/.nix-profile/plan9/font/lucsans/latin1.13.font"

source ~/.extras.sh
