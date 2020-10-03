#!/usr/bin/env bash

install_dir="$HOME/.navigator-home"

DEFAULT="\e[0m"
DEFAULTBOLD="\e[1m"

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"

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
            echo -e "${YELLOW}$serial\t---------------\t${DEFAULT}${DEFAULTBOLD}${MAGENTA}$d${DEFAULT}"
        else                                                                                                                    
            echo -e "${YELLOW}$serial\t---------------\t${DEFAULT}${DEFAULTBOLD}${BLUE}$d${DEFAULT}"
        fi                                                                                                                      
    else
        if [[ $d =~ ^\..*$ ]]; then
            echo -e "${YELLOW}$serial\t---------------\t${DEFAULT}${DEFAULTBOLD}${MAGENTA}$d${DEFAULT}"
        else                                                                                                                    
            echo -e "${YELLOW}$serial\t---------------\t${DEFAULT}${DEFAULTBOLD}${BLUE}$d${DEFAULT}"
        fi                                                                                                                      
    fi
}

# To print the heading and the back option.
print_heading() {
    # Printing the heading-
    echo -e "${RED}No.\t \tDirectory${DEFAULT}"
}

# To specify arguments to display hidden or all directories, if needed, and to print directories in different ways for zsh and bash.
directory_chooser() {
    local current_shell=$(ps -p $$ -ocomm=)
    
    # If the current directory isn't / then display the option to back using 0.
    if [[ "$PWD" != "/" && ! -z $non_hidden_directories ]]; then
        echo -e "${YELLOW}0\t---------------\t${DEFAULT}${DEFAULTBOLD}${BLUE}..${DEFAULT}"
    fi

    # If current shell is zsh, then use */ and .*/ to print directory names.
    if [[ $current_shell = 'zsh' ]]; then

        if [[ $1 = "-h" || $1 = "--hidden" ]]; then
            if [[ -z $hidden_directories ]]; then
                echo -e "No hidden directories to navigate to. Use nn to view all non-hidden directories, if any. Use 0 to go back to the previous directory.\n\n"
                return 0
            fi

            for d in .*/; do
                echo -e "${YELLOW}$serial\t---------------\t${DEFAULT}${DEFAULTBOLD}${MAGENTA}$d${DEFAULT}"
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

            elif [[ -z $non_hidden_directories && -z $hidden_directories ]]; then
		echo "No directories to navigate to. Enter 0 to go back to the previous directory."

            else
                if [[ ! -z $non_hidden_directories && -z $hidden_directories ]]; then
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
            fi

        else
            if [[ -z $non_hidden_directories ]]; then
                echo -e "No non hidden directories available. Use nn -h to view hidden directories, if any. Enter 0 to go back to the previous directory."
                return 0
            fi

            for d in */; do
                echo -e "${YELLOW}$serial\t---------------\t${DEFAULT}${DEFAULTBOLD}${BLUE}$d${DEFAULT}"
                directory_list+=("$d")
                serial=$((serial+1))
            done
        fi

    # If current shell is bash, then use the lists made using find to print directory names
    else 
        IFS=$'\n'
        if [[ $1 = "-h" || $1 = "--hidden" ]]; then
            if [[ -z $hidden_directories ]]; then
                echo -e "No directories to navigate to\n"
                return 0
            fi

            for d in $hidden_directories; do
                echo -e "${YELLOW}$serial\t---------------\t${DEFAULT}${DEFAULTBOLD}${MAGENTA}$d${DEFAULT}"
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
                echo -e "${YELLOW}$serial\t---------------\t${DEFAULT}${DEFAULTBOLD}${BLUE}$d${DEFAULT}"
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

    echo -e "\n\e[100m\e[97m current directory ${DEFAULT}\e[90m\e[44m${DEFAULT}\e[44m\e[30m$PWD ${DEFAULT}${BLUE}${DEFAULT}\n"

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

    directory_chooser $1 > >( { column -t -s $'\t'; printf "Enter the directory number (s to stop)\n${GREEN}|-> ${DEFAULT} "; } )

    read -r number

    # Entering any letter(s) stops the script, leaving the user in the last chosen directory.
    # if [[ $number =~ [A-Za-z]+ ]]; then
    #     return 0
    # fi

    if [[ "$number" == "c" ]]; then
    	clear
	navigator
    fi

    if [[ "$number" -ge 0 && "$number" -lt $serial ]] 2>/dev/null; then
        if [[ "$number" == "0" && "$PWD" != "/" ]]; then
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
