#!/bin/sh

cd $(dirname $0)
DOTFILES=$(pwd)

# comment what you do not want to link

##############
# SUPER USER #
##############
#sudo cp configuration.nix /etc/nixos/configuration.nix
#sudo cp hosts /etc/nixos/hosts
#sudo cp hosts /etc/hosts

###############
# NORMAL USER #
###############
#ln -s $DOTFILES/Xresources ~/.Xresources
#ln -s xinitrc ~/.xinitrc
#ln -s xmobarrc ~/.xmobarrc
#ln -s xmonad ~/.xmonad
ln -s bash_profile ~/.bash_profile
ln -f -s $DOTFILES/init.vim ~/.vimrc && ln -f -s ~/.vimrc ~/.config/nvim/init.vim
ln -f -s $DOTFILES/tmux.conf ~/.tmux.conf
ln -f -s $DOTFILES/zshrc ~/.zshrc

################
# VIM PACKAGES #
################
vimpath=~/.config/vim
# Pathogen
mkdir -p $vimpath/autoload $vimpath/bundle && \
curl -LSso $vimpath/autoload/pathogen.vim https://tpo.pe/pathogen.vim
# Zenburn
cd ~/dig/
git clone https://github.com/jnurmine/Zenburn
cp -r Zenburn/colors $vimpath
# Dirvish
git clone https://github.com/justinmk/vim-dirvish $vimpath/bundle/vim-dirvish
# Commentary
git clone https://github.com/tpope/vim-commentary $vimpath/bundle/vim-commentary
# Surround
git clone https://github.com/tpope/vim-surround $vimpath/bundle/vim-surround
# Lightline
git clone https://github.com/itchyny/lightline.vim $vimpath/bundle/lightline.vim
