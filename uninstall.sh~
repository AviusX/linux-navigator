#!/usr/bin/env bash

if [[ -e ~/.zshrc ]] then

    if [[ -e ~/.bashrc ]] && [[ $SHELL =~ 'zsh' ]] then
        sed -i "/^alias nav/d" ~/.zshrc
        sed -i "/^alias nav/d" ~/.bashrc
        source ~/.zshrc

    elif [[ -e ~/.bashrc ]] && [[ ! $SHELL =~ 'zsh' ]] then
        sed -i "/^alias nav/d" ~/.zshrc
        sed -i "/^alias nav/d" ~/.bashrc
        source ~/.bashrc

    else
        sed -i "/^alias nav/d" ~/.zshrc
        source ~/.zshrc

    fi

else
    sed -i "/^alias nav/d" ~/.bashrc
    source ~/.bashrc

fi

rm -rfv ~/linux-navigator

cd ~
