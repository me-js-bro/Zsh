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

present_dir=`pwd`

packages=(
    bat
    curl
    git
    lsd
    zsh
)

sleep 2

# check which distro
check_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        
        if [ "$ID" == "linuxmint" ] || [ "$NAME" == "Linux Mint" ]; then
            printf "\e[38;5;47m󰣭\e[1;0m\n"
        else
            case "$ID" in
                ubuntu)
                    printf "${action} => Starting script for \e[38;5;208m\[e1;0m\n"
                    pkg_man="apt"
                    ;;
                debian)
                    printf "${action} => Starting script for \e[38;5;89m\e[1;0m\n"
                    pkg_man="apt"
                    ;;
                zorin)
                    printf "${action} => Starting script for \e[38;5;81m\e[1;0m\n"
                    pkg_man="apt"
                    ;;
                pop)
                    printf "${action} => Starting script for \e[38;5;37m\e[1;0m\n"
                    pkg_man="apt"
                    ;;
                kali)
                    printf "${action} => Starting script for \e[1;34\e[1;0m\n"
                    pkg_man="apt"
                    ;;
                parrot)
                    printf "${action} => Starting script for \e[1;32m\e[1;0m\n"
                    pkg_man="apt"
                    ;;
                arch)
                    printf "${action} => Starting script for \e[1;36m󰣇\e[1;0m\n"
                    pkg_man="pacman"
                    ;;
                manjaro)
                    printf "${action} => Starting script for \e[38;5;47m\e[1;0m\n"
                    pkg_man="pacman"
                    ;;
                arcolinux)
                    printf "${action} => Starting script for \e[38;5;81m\e[1;0m\n"
                    pkg_man="pacman"
                    ;;
                fedora)
                    printf "${action} => Starting script for \e[38;5;33m\e[1;0m\n"
                    pkg_man="dnf"
                    ;;
                opensuse*)
                    printf "${action} => Starting script for \e[38;5;47m \e[1;0m\n"
                    pkg_man="zypper"
                    ;;
                *)
                    printf "${red}[ SORRY ]${end} => ${yellow}Your distro is not available right now. Very soon we will add your distro${end}... \n"
                    ;;
            esac
        fi
    else
        printf "\n"
    fi
}

check_distro && sleep 1

# package installation function
fn_install() {

    if $(command -v pacman) &> /dev/null; then  # Arch Linux
        sudo pacman -S --noconfirm "$1"
    elif $(command -v dnf) &> /dev/null; then  # Fedora
        sudo dnf install -y "$1"
    elif $(command -v zypper) &> /dev/null; then  # openSUSE
        sudo zypper in "$1"
    elif $(command -v apt) &> /dev/null; then	# ubuntu or ubuntu based
    	sudo apt install "$1"
    elif $(command -v xbps-install) &> /dev/null ; then # void
        sudo xbps-install -y "$1"
    else
        echo "Unsupported distribution."
        return 1
    fi
}

for pkgs in "${packages[@]}"; do
   fn_install "$pkgs"
done

clear

# ---- oh-my-zsh installation ---- #
printf "${attention} - Now installing ${yellow} oh-my-zsh, zsh-autosuggestions, zsh-syntax-highlighting${end}...\n"
sleep 2

oh_my_zsh_dir="$HOME/.oh-my-zsh"

if [ -d "$oh_my_zsh_dir" ]; then
    printf "${attention} - $oh_my_zsh_dir was located. Backing it up\n"
    mv $oh_my_zsh_dir "$oh_my_zsh_dir-${USER}"
fi

 	  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \

printf "${done} - Installation completed... Now changing default shell to ${cyan}zsh${end} \n"
    chsh -s $(which zsh)
sleep 1

printf "${attention} - Now proceeding to the next step Configuring $HOME/.zshrc file\n"
sleep 2

# Check and backup the directories and file
for item in "$HOME/.zsh" "$HOME/.zshrc" "$HOME/.config/lsd"; do
    if [[ -d $item ]]; then
        case $item in
            $HOME/.zsh)
                printf "${note} - A ${green}.zsh${end} directory is available... Backing it up\n" 
                cp -r "$item" "$HOME/.zsh-back" 2>&1 | tee -a "$log"
                ;;
            $HOME/.config/lsd)
                printf "${note} - A ${yellow}~/.config/lsd${end} directory is available... Backing it up\n" 
                cp -r "$item" "$HOME/.config/lsd-back" 2>&1 | tee -a "$log"
                ;;
        esac
    elif [[ -f $item ]]; then
        case $item in
            $HOME/.zshrc)
                printf "${note} - A ${cyan}.zshrc${end} file is available... Backing it up\n" 
                cp "$item" "$HOME/.zshrc-back-main" 2>&1 | tee -a "$log"
                ;;
        esac
    fi
done

sleep 1

printf "${action} - Copying configs\n"
sleep 1
cp -r "$present_dir/.zsh" "$HOME/"
ln -sf "$HOME/.zsh/.zshrc" "$HOME/.zshrc"

printf "${done} - Installation and configuration of zsh and oh-my-zsh finished!\n"
sleep 1 && clear

#___________________ Theme

# Print the first part of the message
printf "${green}[${end} Themes ${green}]${end} - ${yellow}"

# Define the message for the typewriter effect
message="If you want to change themes of your zsh prompt. Just follow these steps below..."

# Function to print with typewriter effect
typewriter() {
    local text="$1"
    local delay="$2"
    for (( i=0; i<${#text}; i++ )); do
        printf "%s" "${text:$i:1}"
        sleep "$delay"
    done
    printf "${end}\n"
}

# Call the function with the message and a delay of 0.05 seconds
typewriter " $message" 0.07

sleep 0.5

printf "\n\n${yellow}[ STEPS ]${end}\n" && sleep 0.7
printf "${yellow}1.${end} Open your terminal and type ${yellow}theme${end}. It will generate oh-my-zsh themes randomly.\n" && sleep 0.5
printf "${yellow}2.${end} Now copy the name of the theme you liked.\n" && sleep 0.5
printf "${yellow}3.${end} Open ${yellow}$HOME/.zsh/.zshrc${end} file with your favourith text editor. and you will find ${yellow}ZSH_THEME=\"af-magic\"${end}.\n" && sleep 0.5
printf "${yellow}4.${end} Change the ${yellow}\"af-magic\"${end} with the theme name you copied.\n" && sleep 0.5
printf "${yellow}5.${end} Now type the command ${yellow}source ~/.zsh/.zshrc${end} and done....\n" && sleep 0.5