#!/usr/bin/env bash

install_dir="/home/$USER/.navigator-home"

# To check if correct arguments were passed and to display help.
argument_checker() {
    case $1 in
        --help)
            cat "$install_dir/help.txt"
            return 1
            ;;

        -h | --hidden | -a | --all)
            return 0
            ;;
        *)
            echo "Invalid argument. Do nn --help to view usage."
            return 1
            ;;
    esac

}
# To print hidden and non-hidden directory names in different colors.
print_directory_names() {
    if [[ $current_shell =~ "zsh" ]]; then
        if [[ $d =~ "\..*" ]]; then
            echo -e "\e[33m$serial\t---------------\t\e[0m\e[1m\e[35m$d\e[0m" >> "$install_dir/.directories.txt"                
        else                                                                                                                    
            echo -e "\e[33m$serial\t---------------\t\e[0m\e[1m\e[34m$d\e[0m" >> "$install_dir/.directories.txt"                
        fi                                                                                                                      
    else
        if [[ $d =~ ^\..*$ ]]; then
            echo -e "\e[33m$serial\t---------------\t\e[0m\e[1m\e[35m$d\e[0m" >> "$install_dir/.directories.txt"                
        else                                                                                                                    
            echo -e "\e[33m$serial\t---------------\t\e[0m\e[1m\e[34m$d\e[0m" >> "$install_dir/.directories.txt"                
        fi                                                                                                                      
    fi
}

# To specify arguments to display hidden or all directories, if needed, and to print directories in different ways for zsh and bash.
directory_chooser() {
    local current_shell=$(ps -p $$ -ocomm=)

    # If current shell is zsh, then use */ and .*/ to print directory names.
    if [[ $current_shell = 'zsh' ]]; then

        if [[ $1 = "-h" || $1 = "--hidden" ]]; then
            if [[ -z $hidden_directories ]]; then
                echo "No directories to navigate to"
                return 0
            fi

            for d in .*/; do
                echo -e "\e[33m$serial\t---------------\t\e[0m\e[1m\e[35m$d\e[0m" >> "$install_dir/.directories.txt"
                directory_list+=("$d")
                serial=$((serial+1))
            done

        elif [[ $1 = "-a" || $1 = "--all" ]]; then
            if [[ -z $non_hidden_directories && ! -z $hidden_directories ]]; then
                for d in .*/; do
                    # Checking if directory names start from '.' or not to print hidden and non hidden directories in different colors.
                    print_directory_names
                    directory_list+=("$d")
                    serial=$((serial+1))
                done

            elif [[ ! -z $non_hidden_directories && -z $hidden_directories ]]; then
                for d in */; do
                    # Checking if directory names start from '.' or not to print hidden and non hidden directories in different colors.
                    print_directory_names
                    directory_list+=("$d")
                    serial=$((serial+1))
                done

            else
                for d in $(echo */ && echo .*/); do
                    # Checking if directory names start from '.' or not to print hidden and non hidden directories in different colors.
                    print_directory_names
                    directory_list+=("$d")
                    serial=$((serial+1))
                done
            fi

        else
            for d in */; do
                echo -e "\e[33m$serial\t---------------\t\e[0m\e[1m\e[34m$d\e[0m" >> "$install_dir/.directories.txt"
                directory_list+=("$d")
                serial=$((serial+1))
            done
        fi

    # If current shell is bash, then use the lists made using find to print directory names
    else 
        IFS=$'\n'
        if [[ $1 = "-h" || $1 = "--hidden" ]]; then
            if [[ -z $hidden_directories ]]; then
                echo "No directories to navigate to"
                return 0
            fi

            for d in $hidden_directories; do
                echo -e "\e[33m$serial\t---------------\t\e[0m\e[1m\e[35m$d\e[0m" >> "$install_dir/.directories.txt"
                directory_list+=("$d")
                serial=$((serial+1))
            done

        elif [[ $1 = "-a" || $1 = "--all" ]]; then
            if [[ -z $non_hidden_directories && ! -z $hidden_directories ]]; then
                for d in $hidden_directories; do
                    # Checking if directory names start from '.' or not to print hidden and non hidden directories in different colors.
                    print_directory_names
                    directory_list+=("$d")
                    serial=$((serial+1))
                done

            elif [[ ! -z $non_hidden_directories && -z $hidden_directories ]]; then
                for d in $non_hidden_directories; do
                    # Checking if directory names start from '.' or not to print hidden and non hidden directories in different colors.
                    print_directory_names
                    directory_list+=("$d")
                    serial=$((serial+1))
                done

            else
                for d in $directories; do
                    # Checking if directory names start from '.' or not to print hidden and non hidden directories in different colors.
                    print_directory_names
                    directory_list+=("$d")
                    serial=$((serial+1))
                done
            fi
        else
            for d in $non_hidden_directories; do
                echo -e "\e[33m$serial\t---------------\t\e[0m\e[1m\e[34m$d\e[0m" >> "$install_dir/.directories.txt"
                directory_list+=("$d")
                serial=$((serial+1))
            done
        fi
    fi

}

navigator() {
    local serial=1
    local directory_list=("#")
    local current_shell=$(ps -p $$ -ocomm=)

    # Indicating pwd since it can get confusing during recursive use (powerline style)

    echo -e "\n\e[100m\e[97m current directory \e[0m\e[90m\e[44m\e[0m\e[44m\e[30m$PWD \e[0m\e[34m\e[0m\n"

    echo -e "\e[31mNo.\t \tDirectory\e[0m" > "$install_dir/.directories.txt"

    local directories=$(find . -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort)
    local hidden_directories=$(find . -maxdepth 1 -regex ".*/\.+.*" -type d -exec basename {} \; | sort)
    local non_hidden_directories=$(find . -maxdepth 1 -regex ".*/[^\.].+" -type d -exec basename {} \; | sort)

    if [[ -z $non_hidden_directories && ! -z $hidden_directories && $# = 0 ]]; then
        echo "No non hidden directories available. Use \"nn -a\" or \"nn -h\" to view hidden directories."
        return 0
    fi
    
    # if [[ -z $directories ]]; then
    #     echo No subdirectories to navigate to
    #     return 0
    # fi

    if [[ "$PWD" != "/" ]]; then
        echo -e "\e[33m0\t---------------\t\e[0m\e[1m\e[34m..\e[0m" >> "$install_dir/.directories.txt"
    fi

    directory_chooser $1

    cat "$install_dir/.directories.txt" | column -t -s $'\t'
    rm "$install_dir/.directories.txt"
    
    echo "Enter the directory number (s to stop)- " && read -r number

    # Entering any letter(s) stops the script, leaving the user in the last chosen directory.
    if [[ $number =~ [A-Za-z]+ ]]; then
        return 0
    fi
    
    if [[ "$number" -ge 0 && "$number" -lt $serial ]] 2>/dev/null; then
        if [[ "$number" -eq 0 && "$PWD" != "/" ]]; then
            cd ..

        else
            [[ $current_shell =~ 'zsh' ]] && number=$((number+1))
            [[ -d "${directory_list[number]}" ]] && cd "${directory_list[number]}" || echo "Failed to change directory"
        fi

    else
        echo "Invalid choice"
        return 1
    fi

    navigator $1
}

if [[ $# -ne 0 ]]; then
    argument_checker $1 && navigator $1
    return 0
else
    navigator
fi
