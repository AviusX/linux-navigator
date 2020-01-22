# linux-navigator
A simple tool to list all directories in pwd and cd into them with just a number. (Compatible with Bash and Zsh)

![](/images/preview.png)

## Installation Guide

Simply copy and paste the following commands one-by-one to install the tool-
```
cd ~/Downloads
git clone https://github.com/AviusX/linux-navigator/
cd linux-navigator
source install.sh
```
That's it! Now you can glide your way around directories with the `nn` command. See `nn --help` or see usage below.

If you get `permission denied`, then make the script executable by running
```
chmod +x ./install.sh
```

## Usage

  #### General

   1. After installation, simple run `nn` in any directory to view all directories in your pwd.
   2. Enter the directory number to go into that directory.
   3. Once you reach your desired directory, enter any letter to stop.
   
  #### Viewing all directories
   1. Type `nn -a` or `nn --all` to view all directories (both hidden and non-hidden).
   2. Navigate the same way as you would with general usage.
   
  #### Viewing hidden directories only
   1. Type `nn -h` or `nn --hidden` to view hidden directories only.
   2. Navigate the same way as you would with general usage.
   
  #### Viewing help
   1. Type `nn --help` to view print help and view command usage and options.

## Uninstallation

To uninstall, copy and paste the following command-
```
source ~/.navigator-home/uninstall.sh
```
That's it! 

### Warning!

##### This tool sets an alias `nn` in your shell rc file to work. Feel free to change the alias to whatever you want. However, changing the tool path will result in both the main tool and uninstall script to stop working. If you don't know how to do that, please don't change the path of your tool.

##### Changing the tool's path properly will require you to change the `install_dir` variable in all scripts as well as changing the alias in your shell's rc file (.bashrc or .zshrc). You may also need to change your uninstall script to properly remove the alias line during uninstall or remove the line manually from your shell rc file after uninstallation.
