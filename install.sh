#!/usr/bin/env bash

install_dir=~/Navigator

# make sure we got execute access on the main script
chmod +x navigator.sh
# create the new home directory for this to live in
mkdir -p ~/Navigator

# only copy over the scripts (files) we dont need the .git files
find . -maxdepth 1 -type f -exec cp -vuf {} $install_dir/ \;

install_alias() {
    # pass a shell name in e.g. bash or zsh
    local shell_rc_file=~/.$1rc
    [[ -f $shell_rc_file ]] && echo "alias nav=\". ${install_dir}/navigator.sh\"" >> "$shell_rc_file"
    # now source the file if it is the current shell
    [[ $(ps -p $$ -ocomm=) == "$1" ]] && source "$shell_rc_file"
}

install_alias bash
install_alias zsh
