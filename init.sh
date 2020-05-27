#!/bin/sh

cd $(dirname $0)
DOTFILES=$(pwd)

# comment what you do not want to link

##############
# SUPER USER #
##############
#sudo cp configuration.nix /etc/nixos/configuration.nix
#sudo cp hosts /etc/nixos/hosts
sudo cp hosts /etc/hosts

###############
# NORMAL USER #
###############
#ln -s $DOTFILES/Xresources ~/.Xresources
#ln -s xinitrc ~/.xinitrc
#ln -s xmobarrc ~/.xmobarrc
#ln -s xmonad ~/.xmonad
#ln -s bash_profile ~/.bash_profile
ln -f -s $DOTFILES/init.vim ~/.vimrc && ln -f -s ~/.vimrc ~/.config/nvim/init.vim
ln -f -s $DOTFILES/tmux.conf ~/.tmux.conf
ln -f -s $DOTFILES/zshrc ~/.zshrc
