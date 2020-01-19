#!/usr/bin/env bash

install_dir="/home/$USER/.navigator-home"

if [[ -e ~/.zshrc ]]; then

    if [[ -e ~/.bashrc ]] && [[ $SHELL =~ 'zsh' ]]; then
        sed -i "/^alias.*navigator-home\/navigator.sh\"$/d" ~/.zshrc
        sed -i "/^alias.*navigator-home\/navigator.sh\"$/d" ~/.bashrc

    elif [[ -e ~/.bashrc ]] && [[ ! $SHELL =~ 'zsh' ]]; then
        sed -i "/^alias.*navigator-home\/navigator.sh\"$/d" ~/.zshrc
        sed -i "/^alias.*navigator-home\/navigator.sh\"$/d" ~/.bashrc

    else
        sed -i "/^alias.*navigator-home\/navigator.sh\"$/d" ~/.zshrc

    fi

else
    sed -i "/^alias.*navigator-home\/navigator.sh\"$/d" ~/.bashrc

fi

rm -rfv "$install_dir"

cd ~
