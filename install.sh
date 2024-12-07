#!/bin/bash

#---------------#
# ┏┳    ┳┓    
#  ┃┏   ┣┫┏┓┏┓
# ┗┛┛•  ┻┛┛ ┗┛     
#---------------#

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

# log file
dir=`pwd`
log="$dir/zsh-install-$(date +%I:%M_%p).log"
touch "$log"

# required packages
common_packages=(
    bat
    curl
    eza
    fastfetch
    figlet
    fzf
    git
    xclip
    zoxide
)

for_opensuse=(
    python311
    python311-pip
    python311-pipx
    xclip
)

# package installation function
fn_install() {
    local pkg=$1

    if [ -n "$(command -v pacman)" ]; then  # Arch Linux
        sudo pacman -S --noconfirm "$pkg" 2>&1 | tee -a "$log"
    elif [ -n "$(command -v dnf)" ]; then  # Fedora
        sudo dnf install -y "$pkg" 2>&1 | tee -a "$log"
    elif [ -n "$(command -v zypper)" ]; then # opensuse
        sudo zypper in -y "$pkg" 2>&1 | tee -a "$log"
    elif [ -n "$(command -v apt)" ]; then	# debian
        sudo apt install -y "$pkg" 2>&1 | tee -a "$log"
    else

        if [[ "$(uname)" == "Darwin" ]]; then
            echo "Running on macOS..."
            if [ -n "$(command -v brew)" ]; then
                brew install "$pkg" 2>&1 | tee -a "$log"
            elif [ -z "$(command -v brew)" ]; then
                echo "Homebrew is not installed. Install it from https://brew.sh/ before running this script."
                exit 1
            fi
        fi
   fi
}

# install the packages
for pkgs in "${common_packages[@]}"; do
   fn_install "$pkgs" 2>&1 | tee -a "$log"
done

if command -v zypper &> /dev/null; then
    for pkgs in "${for_opensuse[@]}"; do
        sudo zypper in -y "$pkgs" 2>&1 | tee -a "$log"
    done

    # installing thefu*k
    if command -v pipx &> /dev/null; then
        pipx runpip thefuck install setuptools &> /dev/null
        sleep 0.5
        pipx install --python python3.11 thefuck &> /dev/null 2>&1 | tee -a "$log"

        if command -v thefuck &> /dev/null; then
            printf "${done} - thef*ck was installed successfully!\n" && sleep 1
        fi
    fi

elif command -v pacman &> /dev/null; then  # Arch Linux
    sudo pacman -S --noconfirm thefuck 2>&1 | tee -a "$log"
elif command -v dnf &> /dev/null; then  # Fedora
    sudo dnf install -y thefuck 2>&1 | tee -a "$log"
elif command -v brew &> /dev/null; then
    brew install thefuck 2>&1 | tee -a "$log"
fi


printf "${attention} - Installing bash files...\n \n \n" && sleep 0.5


# ---- oh-my-zsh installation ---- #
printf "${attention}\n==> Now installing ${yellow} oh-my-zsh, zsh-autosuggestions, zsh-syntax-highlighting${end}...\n"
sleep 2

oh_my_zsh_dir="$HOME/.oh-my-zsh"

if [ -d "$oh_my_zsh_dir" ]; then
    printf "${attention} - $oh_my_zsh_dir was located. Backing it up\n"
    mv $oh_my_zsh_dir "$oh_my_zsh_dir-${USER}"
fi

 	  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k \

printf "${done} - Installation completed... Now changing default shell to ${cyan}zsh${end} \n"
chsh -s $(which zsh)
sleep 1

printf "${attention} - Now proceeding to the next step Configuring $HOME/.zshrc file\n"
sleep 2

# Check and backup the directories and file
mkdir -p "$HOME/.Zsh-Backup"-${USER}
for item in "$HOME/.zsh" "$HOME/.zshrc" "$HOME/.p10k.zsh"; do
    if [[ -d $item ]]; then
        case $item in
            $HOME/.zsh)
                printf "${note} - A ${green}.zsh${end} directory is available... Backing it up\n" 
                mv "$item" "$HOME/.Zsh-Backup"-${USER}/
                ;;
        esac
    elif [[ -f $item ]]; then
        case $item in
            $HOME/.zshrc)
                printf "${note} - A ${cyan}.zshrc${end} file is available... Backing it up\n" 
                mv "$item" "$HOME/.Zsh-Backup"-${USER}/
                ;;
            $HOME/.p10k.zsh)
                printf "${note} - A ${cyan}.zshrc${end} file is available... Backing it up\n" 
                mv "$item" "$HOME/.Zsh-Backup"-${USER}/
                ;;
        esac
    fi
done

sleep 1

printf "${action} - Copying configs\n"
sleep 1
cp -r .zsh .p10k.zsh ~/
ln -sf "$HOME/.zsh/.zshrc" "$HOME/.zshrc"

printf "${done} - Installation and configuration of zsh and oh-my-zsh finished!\n"
sleep 1

#___________________ Theme

# Define the message for the typewriter effect
message="Installation completed. Just close and open the terminal again."

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
clear
typewriter " $message" 0.07
exit 0
