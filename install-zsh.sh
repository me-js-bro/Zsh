#!/bin/bash



printf "#--------------------------------------------#\n"
printf "\n"
printf "# zsh and oh-my-zsh install script by Js Bro #\n"
printf "\n"
printf "#--------------------------------------------#\n"


printf "\n"
printf "\n"

sleep 2

# ---- Defining Colorful ACTs ---- #
ATT="\e[1;33m[ ATTENTION ]\e[0m"
ACT="\e[1;32m[ ACTION ]\e[0m"
NOTE="\e[1;35m[ NOTE ]\e[0m"
DONE="\e[1;36m[ DONE ]\e[0m"
ERROR="\e[1;31m[ ERROR ]\e[0m"

clear

# ---- Asking user for install zsh ---- #
printf "${ATT} - This script for installing zsh, oh-my-zsh and configuring theme has been executed.\nThis may ask for your sudo password to change shell... Would you like to install \e[36m' zsh '\e[0m first? ( y/n )\n"
sleep 1

read -n1 -rep "Select: " user_agreed

sleep 1

clear

if [[ $user_agreed == "y" || $user_agreed == "Y" ]]; then

    printf "${NOTE} - Please choose your distro...\nDebian/Ububtu: ( D/d )\nArch/Arch based: ( A/a )\nFedora/Fedora based: ( F/f )\nOpenSuse: ( O/o )\nVoid Linux: ( V/v )\nOpenBSD: ( OB/Ob/ob )\nFreeBSD: ( FB/Fb/fb )\nCentOs/RHEL: ( R/r )\n"
    read -p "Select: " distro

    sleep 1

    case "$distro" in
        D|d) printf "${ACT} - Installing zsh in your distro\n"
            package_man="apt install"
            ;;
        A|a) printf "${ACT} - Installing zsh in your distro\n"
            package_man="pacman -S"
            ;;
        F|f) printf "${ACT} - Installing zsh in your distro\n"
            package_man="dnf install"
            ;;
        O|o) printf "${ACT} - Installing zsh in your distro\n"
            package_man="zypper install"
            ;;
        V|v) printf "${ACT} - Installing zsh in your distro\n"
            package_man="xbps-install"
            ;;
        OB|Ob|ob) printf "${ACT} - Installing zsh in your distro\n"
            package_man="pkg_add"
            ;;
        FB|Fb|fb) printf "${ACT} - Installing zsh in your distro\n"
            package_man="pkg install"
            ;;
        R|r) printf "${ACT} - Installing zsh in your distro\n"
            package_man="yum -y install"
            ;;
        *) printf "${ERROR} - Please choose a valid option\n"
    esac
    sleep 1

    # ---- Installation process ---- #
    sudo $package_man zsh curl git -y

else
    printf "${ATT} - Proceeding to the next step \e[33m' oh-my-zsh installation '\e[0m\n"

fi

# ---- oh-my-zsh installation ---- #
printf "${ATT} - Now installing \e[33m' oh-my-zsh, zsh-autosuggestions, zsh-syntax-highlighting, powerlevel10k theme '\e[0m...\n"
sleep 2

oh_my_zsh_dir="$HOME/.oh-my-zsh"

if [ -d "$oh_my_zsh_dir" ]; then
    printf "${ATT} - $oh_my_zsh_dir located, it is necessary to remove or rename it for the installation process. So renaming the directory...\n"
    mv $oh_my_zsh_dir "$oh_my_zsh_dir-back"
fi

 	  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && \

printf "${DONE} - Installation completed... Now changing default shell to \e[36m' zsh '\e[0m\n"
    chsh -s $(which zsh)
sleep 1

printf "${ATT} - Now proceeding to the next step '\e[33m[ Configuring $HOME/.zshrc file ]\e[0m'\n"
sleep 2

  if [ -f ~/.zshrc ]; then
    printf "${ACT} - Backing up the .zshrc to .zshrc.back\n"
        mv ~/.zshrc ~/.zshrc.back
    sleep 1

    printf "${DONE} - Backup done\n"
  fi

  if [ -f ~/.p10k.zsh ]; then
    printf "${ACT} - Backing up the .p10k.zsh file to .p10k.zsh.back\n"
        mv ~/.p10k.zsh ~/.p10k.zsh.back
  fi
  sleep 1


zshrc_file='./files/.zshrc'
p10k_file='./files/.p10k.zsh'

printf "${ACT} - Copying '$zshrc_file' and '$p10k_file' to the '$HOME/' directory\n"
sleep 1

cp $zshrc_file $p10k_file "$HOME/"

printf "${DONE} - Installation and configuration of \e[36m' zsh and oh-my-zsh '\e[0m finished!\n"
printf "${NOTE} - You can always configure the powerlevel10k theme with the \e[33m' p10k configure '\e[0m command in your termianal.\n"

sleep 3

printf "Have a good day/night,,,\n"
sleep 1
exit
