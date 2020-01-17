#!/usr/bin/env bash

chmod +x navigator.sh
cp -rv $(pwd) ~/

if [[ -e ~/.zshrc ]] then

    if [[ -e ~/.bashrc ]] && [[ $SHELL =~ 'zsh' ]] then
        echo "alias nav='. ~/linux-navigator/navigator.sh'" >> ~/.zshrc
        echo "alias nav='. ~/linux-navigator/navigator.sh'" >> ~/.bashrc
        source ~/.zshrc
    elif [[ -e ~/.bashrc ]] && [[ ! $SHELL =~ 'zsh' ]] then
        echo "alias nav='. ~/linux-navigator/navigator.sh'" >> ~/.zshrc
        echo "alias nav='. ~/linux-navigator/navigator.sh'" >> ~/.bashrc
        source ~/.bashrc   
    else
        echo  "alias nav='. ~/linux-navigator/navigator.sh'" >> ~/.zshrc
        source ~/.zshrc
    fi

else
    echo "alias nav='. ~/linux-navigator/navigator.sh'" >> ~/.bashrc
    source ~/.bashrc

fi

rm ~/linux-navigator/install.sh*
rm ~/linux-navigator/.install.sh.un~
rm -rfv ~/linux-navigator/.git
cd ~
