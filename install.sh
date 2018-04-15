#!/bin/bash

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".config" ]] && continue

    ln -s `pwd`/$f
done

ln -s `pwd`/.config/i3/config ~/.config/i3/config
