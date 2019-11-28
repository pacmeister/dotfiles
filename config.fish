#!/usr/bin/env fish

function fish_right_prompt
    echo -n (set_color yellow)(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/*\(.*\)/\1/')
    if test -n (echo (git status -s 2>/dev/null)); echo (set_color red)" *"(set_color normal); end
end

set -x PATH ~/bin:$PATH
set -x VISUAL nvim
set -x EDITOR nvim
set -x PLASMA_USE_QT_SCALING 1
set -x LESS_TERMCAP_md (printf '\e[01;31m')
set -x LESS_TERMCAP_me (printf '\e[0m')
set -x LESS_TERMCAP_se (printf '\e[0m')
set -x LESS_TERMCAP_so (printf '\e[01;44;33m')
set -x LESS_TERMCAP_ue (printf '\e[0m')
set -x LESS_TERMCAP_us (printf '\e[01;32m')

function vi; nvim $argv; end
function find; du -a $argv | awk '{print \$2}'; end
function cp; rsync -P $argv; end
function dirs; echo (dirs) | sed 's/\s/\n/' | grep -n .; end
function ls; exa $argv; end
function la; exa -a $argv; end
function ll; exa -ahl -snew $argv; end
function tree; exa -T $argv; end
function upgrade; sudo cp ~/git/dotfiles/configuration.nix /etc/nixos && sudo nix-channel --update && sudo nix-collect-garbage -d && sudo nixos-rebuild switch --upgrade; end
function clear; command clear && tmux clear-history; end

source ~/.extras.fish
