#!/bin/bash

sudo cp bin/wifi /usr/local/bin/wifi
sudo cp bin/battery /usr/local/bin/battery
sudo cp bin/getgip /usr/local/bin/getgip
sudo cp bin/getlip /usr/local/bin/getlip

sudo chmod 755 /usr/local/bin/wifi
sudo chmod 755 /usr/local/bin/battery
sudo chmod 755 /usr/local/bin/getgip
sudo chmod 755 /usr/local/bin/getlip

cp .zshrc ~/.zshrc
cp .tmux.conf ~/.tmux.conf

if [ -e /usr/local/bin/zsh ]; then
  chsh -s /usr/local/bin/zsh
else
  chsh -s /bin/zsh
fi


cd ~/
export ZPLUG_HOME=".zplug"
curl -sL git.io/zplug | zsh
