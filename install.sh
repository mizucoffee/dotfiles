#!/bin/bash

ln -s -f `pwd`/.zshrc ~/
ln -s -f `pwd`/.rls.sh ~/
ln -s -f `pwd`/.bar.sh ~/
ln -s -f `pwd`/.battery.sh ~/
ln -s -f `pwd`/.gtkrc-2.0 ~/
ln -s -f `pwd`/.xprofile ~/
mkdir -p ~/.config/nvim/
mkdir -p ~/.config/i3/
ln -s -f `pwd`/.config/nvim/init.vim ~/.config/nvim/
ln -s -f `pwd`/.config/i3/config ~/.config/i3/config

chsh -s /usr/bin/zsh $USER
