#!/bin/zsh

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
#ln -f -s $DOTFILES/Xresources ~/.Xresources
#ln -f -s xinitrc ~/.xinitrc
#ln -f -s xmobarrc ~/.xmobarrc
#ln -f -s xmonad ~/.xmonad
ln -f -s $DOTFILES/bash_profile ~/.bash_profile
ln -f -s $DOTFILES/vimrc ~/.vimrc
ln -f -s $DOTFILES/tmux.conf ~/.tmux.conf
ln -f -s $DOTFILES/zshrc ~/.zshrc

################
# VIM PACKAGES #
################
vimpath=~/.config/vim
# Pathogen
mkdir -p $vimpath/autoload $vimpath/bundle && \
curl -LSso $vimpath/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Zenburn colors
cd ~/dig/
git clone https://github.com/jnurmine/Zenburn
cp -r Zenburn/colors $vimpath

# other plugins
repos=( 
        'https://github.com/justinmk/vim-dirvish'
        'https://github.com/tpope/vim-commentary'
        'https://github.com/tpope/vim-surround' 
        'https://github.com/itchyny/lightline.vim' 
    )
cd $vimpath/bundle
for r in $repos; do
    git clone $r
done
