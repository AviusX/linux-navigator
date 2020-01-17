#!/usr/bin/env bash

serial=1
directory_list=("#")
echo -e "\n\e[31mS.no\t\tDirectory\e[0m\n"
for d in */; do
    echo -e "\e[33m$serial\e[0m\e[1m\e[34m\t\t$d\e[0m"
    directory_list+=($d)
    let serial=serial+1
done
echo "Enter the directory number- " && read number
cd ${directory_list[number+1]}
