#!/bin/bash

FORCE=0
GUI=0
while getopts f OPT
do
  case $OPT in
    "f" ) FORCE=1 ;;
    "g" ) GUI=1 ;;
  esac
done

if [ $(whoami) = "root" -a $FORCE -ne 1 ]; then
  echo "Please run without sudo."
  echo "If you are root, use -f option."
  exit 1
fi

if [ $FORCE -eq 1 ]; then
  mkdir -p ~/.config/i3/
  ln -s -f `pwd`/.rls.sh ~/
  ln -s -f `pwd`/.bar.sh ~/
  ln -s -f `pwd`/.battery.sh ~/
  ln -s -f `pwd`/.gtkrc-2.0 ~/
  ln -s -f `pwd`/.xprofile ~/
  ln -s -f `pwd`/.config/i3/config ~/.config/i3/config
  ln -s -f `pwd`/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini
fi

mkdir -p ~/.config/nvim/
ln -s -f `pwd`/.zshrc ~/
ln -s -f `pwd`/.config/nvim/init.vim ~/.config/nvim/

#ln -s -f `pwd`/syncpw /usr/local/bin/syncpw

if [ $(whoami) = "root" ]; then
  chsh -s /bin/zsh $USER
else
  sudo chsh -s /bin/zsh $USER
fi
