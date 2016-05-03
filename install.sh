#!/bin/bash

curl -sL git.io/zplug | zsh

sudo cp bin/wifi /usr/local/bin/wifi
sudo cp bin/battery /usr/local/bin/battry

sudo chmod 755 /usr/local/bin/wifi
sudo chmod 755 /usr/local/bin/battery

cp .zshrc ~/.zshrc
cp .tmux.conf ~/.tmux.conf
