# linux-navigator
A simple tool to list all directories in pwd and cd into them with just a number. (Compatible with Bash and Zsh)

![](/images/preview.png)

## Installation Guide

Simply copy and paste the following commands one-by-one to install the tool-
```
cd ~/Downloads
git clone https://github.com/AviusX/linux-navigator/
cd linux-navigator
. ./install.sh
```

If you get `permission denied`, then make the script executable by running
```
chmod +x ./install.sh
```

## How to use

1. After installation, simple run `nn` in any directory to view all directories in your pwd.
2. Enter the directory number to go into that directory.
3. Once you reach your desired directory, enter any letter to stop.

## Uninstallation

To uninstall, copy and paste the following command-
```
. ~/.navigator-home/uninstall.sh
```
That's it! 

### Warning!
#### This tool sets an alias `nn` in your shell rc file to work. Feel free to change the alias to whatever you want. However, changing the tool path will result in both the main tool and uninstall script to stop working, unless you make multiple manual changes in the scripts. If you don't know how to do that, please don't change the tool's path.
