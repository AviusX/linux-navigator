#!/usr/bin/env bash

install_dir="/home/$USER/.navigator-home"

# make sure we got execute access on the scripts.
chmod +x navigator.sh
chmod +x uninstall.sh
# create the new home directory for this to live in
mkdir -p "$install_dir"

# only copy over the scripts (files) we dont need the .git files
find . -maxdepth 1 -type f -exec cp -vuf {} $install_dir/ \;
rm "$install_dir/install.sh"
rm "$install_dir/README.md"

install_alias() {
    # pass a shell name in e.g. bash or zsh
    local shell_rc_file=~/.$1rc
    [[ -f $shell_rc_file ]] && echo "alias nn=\". ${install_dir}/navigator.sh\"" >> "$shell_rc_file"
    # now source the file if it is the current shell
    [[ $(ps -p $$ -ocomm=) == "$1" ]] && source "$shell_rc_file"
}

install_alias bash
install_alias zsh

cd ~
