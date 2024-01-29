#!/bin/bash

# color defination
red="\e[1;31m"
green="\e[1;32m"
yellow="\e[1;33m"
blue="\e[1;34m"
megenta="\e[1;1;35m"
cyan="\e[1;36m"
end="\e[1;0m"

# initial texts
attention="${yellow}[ ATTENTION ]${end}"
action="${green}[ ACTION ]${end}"
note="${megenta}[ NOTE ]${end}"
done="${cyan}[ DONE ]${end}"
error="${red}[ ERROR ]${end}"

clear

sleep 1

printf " zsh, oh-my-zsh and powerlevel10k install by, \n"

printf "#--------------------------------------------#\n"
printf "\n"

printf "        |\  /|   /\   |    |( )|\   |   \n"
printf "        | \/ |  /  \  |____| | | \  |   \n"
printf "        |    | /____\ |    | | |  \ |   \n"
printf "        |    |/      \|    |_|_|   \|   \n"

printf "\n"
printf "#--------------------------------------------#\n"


printf "\n"
printf "\n"

sleep 2

# ---- Asking user for install zsh ---- #
printf "${attention} - This script for installing zsh, oh-my-zsh and configuring theme has been executed.\nThis may ask for your sudo password to change shell... Would you like to install ${cyan}zsh${end} first? ( y/n )\n"
sleep 1

read -n1 -rep "Select: " user_agreed

sleep 1

clear

if [[ $user_agreed == "y" || $user_agreed == "Y" ]]; then

    printf "${note} - Please choose your distro...\nDebian/Ububtu: ( D/d )\nArch/Arch based: ( A/a )\nFedora/Fedora based: ( F/f )\nOpenSuse: ( O/o )\nVoid Linux: ( V/v )\nOpenBSD: ( OB/Ob/ob )\nFreeBSD: ( FB/Fb/fb )\nCentOs/RHEL: ( R/r )\n"
    read -p "Select: " distro

    sleep 1

    case "$distro" in
        D|d) printf "${action} - Installing zsh in your distro\n"
            package_man="apt install"
            ;;
        A|a) printf "${action} - Installing zsh in your distro\n"
            package_man="pacman -S --noconfirm"
            ;;
        F|f) printf "${action} - Installing zsh in your distro\n"
            package_man="dnf install -y"
            ;;
        O|o) printf "${action} - Installing zsh in your distro\n"
            package_man="zypper in -y"
            ;;
        V|v) printf "${action} - Installing zsh in your distro\n"
            package_man="xbps-install"
            ;;
        OB|Ob|ob) printf "${action} - Installing zsh in your distro\n"
            package_man="pkg_add"
            ;;
        FB|Fb|fb) printf "${action} - Installing zsh in your distro\n"
            package_man="pkg install"
            ;;
        R|r) printf "${action} - Installing zsh in your distro\n"
            package_man="yum -y install"
            ;;
        *) printf "${ERROR} - Please choose a valid option\n"
    esac
    sleep 1

    # ---- Installation process ---- #
    sudo $package_man zsh curl git

else
    printf "${attention} - Proceeding to the next step ${yellow} oh-my-zsh installation${end}\n"

fi

# ---- oh-my-zsh installation ---- #
printf "${attention} - Now installing ${yellow} oh-my-zsh, zsh-autosuggestions, zsh-syntax-highlighting, powerlevel10k theme${end}...\n"
sleep 2

oh_my_zsh_dir="$HOME/.oh-my-zsh"

if [ -d "$oh_my_zsh_dir" ]; then
    printf "${attention} - $oh_my_zsh_dir located, it is necessary to remove or rename it for the installation process. So renaming the directory...\n"
    mv $oh_my_zsh_dir "$oh_my_zsh_dir-back"
fi

 	  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && \

printf "${done} - Installation completed... Now changing default shell to ${cyan}zsh${end} \n"
    chsh -s $(which zsh)
sleep 1

printf "${attention} - Now proceeding to the next step Configuring $HOME/.zshrc file\n"
sleep 2

  if [ -f ~/.zshrc ]; then
    printf "${action} - Backing up the .zshrc to .zshrc.back\n"
        mv ~/.zshrc ~/.zshrc.back
    sleep 1

  fi

  if [ -f ~/.p10k.zsh ]; then
    printf "${action} - Backing up the .p10k.zsh file to .p10k.zsh.back\n"
        mv ~/.p10k.zsh ~/.p10k.zsh.back
  fi

    printf "${done} - Backup done\n"
  sleep 1


zshrc_file='files/.zshrc'
p10k_file='files/.p10k.zsh'

printf "${action} - Copying '$zshrc_file' and '$p10k_file' to the '$HOME/' directory\n"
sleep 1

cp $zshrc_file $p10k_file "$HOME/"

printf "${done} - Installation and configuration of zsh and oh-my-zsh finished!\n"
printf "${note} - You can always configure the powerlevel10k theme with the ${yellow}p10k configure${end} command in your termianal.\n"

sleep 3

printf "${cyan}Have a good day/night${end} \n"
sleep 1
exit
