#!/usr/bin/env bash

serial=1
directory_list=("#")

directories=$(find . -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort)

if [[ -z $directories ]]; then
    echo No subdirectories to navigate to
    return 0
fi

echo -e "\n\e[31mS.no\t\tDirectory\e[0m\n"
for d in $directories; do
    echo -e "\e[33m$serial\e[0m\e[1m\e[34m\t\t$d\e[0m"
    directory_list+=("$d")
    serial=$((serial+1))
done

echo Enter the directory number: && read -r number

if [[ "$number" -gt 0 && "$number" -lt $serial ]] 2>/dev/null; then
    [[ $SHELL =~ 'zsh' ]] && number=$((number+1))
    [[ -d "${directory_list[number]}" ]] && cd "${directory_list[number]}" || echo Failed to change directory
else
    echo Invalid choice
fi
