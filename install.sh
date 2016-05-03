#!/bin/bash

export ZPLUG_HOME=".zplug"
curl -sL git.io/zplug | zsh

sudo cp bin/wifi /usr/local/bin/wifi
sudo cp bin/battery /usr/local/bin/battry

sudo chmod 755 /usr/local/bin/wifi
sudo chmod 755 /usr/local/bin/battery

cp .zshrc ~/.zshrc
cp .tmux.conf ~/.tmux.conf

if [ -e /usr/local/bin/zsh ]; then
  chsh -s /usr/local/bin/zsh
else
  chsh -s /bin/zsh
fi
