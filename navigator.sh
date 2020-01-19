#!/usr/bin/env bash

navigator() {
    local serial=1
    local directory_list=("#")
    local install_dir="/home/$USER/.navigator-home"

    # Indicating pwd since it can get confusing during recursive use (powerline style)

    echo -e "\n\e[100m\e[97m current directory \e[0m\e[90m\e[44m\e[0m\e[44m\e[30m$PWD \e[0m\e[34m\e[0m\n"

    echo -e "\e[31mNo.\t\tDirectory\e[0m" > "$install_dir/.directories.txt"

    local directories=$(find . -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort)

    if [[ -z $directories ]]; then
        echo No subdirectories to navigate to
        return 0
    fi

    if [[ "$PWD" != "/" ]]; then
        echo -e "\e[33m0\t---------------\t\e[0m\e[1m\e[34m..\e[0m" >> "$install_dir/.directories.txt"
    fi

    for d in */; do
        echo -e "\e[33m$serial\t---------------\t\e[0m\e[1m\e[34m$d\e[0m" >> "$install_dir/.directories.txt"
        directory_list+=("$d")
        serial=$((serial+1))
    done
    
    cat "$install_dir/.directories.txt" | column -t -s $'\t'
    rm "$install_dir/.directories.txt"
    
    echo "Enter the directory number- " && read -r number

    # Entering any letter(s) stops the script, leaving the user in the last chosen directory.
    if [[ $number =~ [A-Za-z]+ ]]; then
        return 0
    fi
    
    if [[ "$number" -ge 0 && "$number" -lt $serial ]] 2>/dev/null; then
        if [[ "$number" -eq 0 && "$PWD" != "/" ]]; then
            cd ..

        else
            [[ $SHELL =~ 'zsh' ]] && number=$((number+1))
            [[ -d "${directory_list[number]}" ]] && cd "${directory_list[number]}" || echo "Failed to change directory"
        fi

    else
        echo "Invalid choice"
        return 1
    fi

    navigator
}

navigator
