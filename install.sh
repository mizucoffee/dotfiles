#!/bin/bash


for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".config" ]] && continue
    [[ "$f" == ".tmux.conf" ]] && continue
    [[ "$f" == ".bar.sh" ]] && ps -e | grep i3 > /dev/null || continue
    [[ "$f" == ".battery.sh" ]] && ps -e | grep i3 > /dev/null || continue

    ln -s -f `pwd`/$f ~
done

ps -e | grep i3 > /dev/null && ln -s `pwd`/.config/i3/config ~/.config/i3/config
