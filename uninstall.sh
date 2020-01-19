#!/usr/bin/env bash

install_dir="/home/$USER/.navigator-home"

if [[ -e ~/.zshrc ]]; then

    if [[ -e ~/.bashrc ]] && [[ $SHELL =~ 'zsh' ]]; then
        sed -i "/^alias nn/d" ~/.zshrc
        sed -i "/^alias nn/d" ~/.bashrc
        source ~/.zshrc

    elif [[ -e ~/.bashrc ]] && [[ ! $SHELL =~ 'zsh' ]]; then
        sed -i "/^alias nn/d" ~/.zshrc
        sed -i "/^alias nn/d" ~/.bashrc
        source ~/.bashrc

    else
        sed -i "/^alias nn/d" ~/.zshrc
        source ~/.zshrc

    fi

else
    sed -i "/^alias nn/d" ~/.bashrc
    source ~/.bashrc

fi

rm -rfv "$install_dir"

cd ~
