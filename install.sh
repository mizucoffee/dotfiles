#!/bin/bash

FORCE=0
while getopts f OPT
do
  case $OPT in
    "f" ) FORCE=1
  esac
done

if [ $(whoami) = "root" -a $FORCE -ne 1 ]; then
  echo "Please run without sudo."
  echo "If you are root, use -f option."
  exit 1
fi

mkdir -p ~/.config/nvim/
mkdir -p ~/.config/i3/

ln -s -f `pwd`/.zshrc ~/
ln -s -f `pwd`/.rls.sh ~/
ln -s -f `pwd`/.bar.sh ~/
ln -s -f `pwd`/.battery.sh ~/
ln -s -f `pwd`/.gtkrc-2.0 ~/
ln -s -f `pwd`/.xprofile ~/
ln -s -f `pwd`/.config/nvim/init.vim ~/.config/nvim/
ln -s -f `pwd`/.config/i3/config ~/.config/i3/config
ln -s -f `pwd`/syncpw /usr/local/bin/syncpw

sudo chsh -s /usr/bin/zsh $USER
