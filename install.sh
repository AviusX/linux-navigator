#!/usr/bin/env bash

chmod +x navigator.sh
cp -rv $(pwd) ~/ && mv ~/linux-navigator Navigator

if [[ -e ~/.zshrc ]] then

    if [[ -e ~/.bashrc ]] && [[ $SHELL =~ 'zsh' ]] then
        echo "alias nav='. ~/Navigator/navigator.sh'" >> ~/.zshrc
        echo "alias nav='. ~/Navigator/navigator.sh'" >> ~/.bashrc
        source ~/.zshrc
    elif [[ -e ~/.bashrc ]] && [[ ! $SHELL =~ 'zsh' ]] then
        echo "alias nav='. ~/Navigator/navigator.sh'" >> ~/.zshrc
        echo "alias nav='. ~/Navigator/navigator.sh'" >> ~/.bashrc
        source ~/.bashrc   
    else
        echo  "alias nav='. ~/Navigator/navigator.sh'" >> ~/.zshrc
        source ~/.zshrc
    fi

else
    echo "alias nav='. ~/Navigator/navigator.sh'" >> ~/.bashrc
    source ~/.bashrc

fi

rm ~/Navigator/install.sh*
rm ~/Navigator/.install.sh.un~
rm -rfv ~/Navigator/.git
cd ~
