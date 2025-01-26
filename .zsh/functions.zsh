# ~/.zsh/functions.sh
#
# copy and paste Function
function cpy() {
  # Get the last argument as the destination
  local destination="${@[-1]}/"

  # Check if the destination exists and is a directory
  if [[ ! -d "$destination" ]]; then
    # If not, create it
    mkdir -p "$destination"
  fi

  # Get all arguments except the last one (items to copy)
  local items=("${@:1:$#-1}")

  # Iterate through the items and copy them
  for item in "${items[@]}"; do
    if [[ -f "$item" ]]; then
      printf ":: Copying a file: %s\n" "$item"
      cp "$item" "$destination"
    elif [[ -d "$item" ]]; then
      printf ":: Copying a directory: %s\n" "$item"
      cp -r "$item" "$destination"
    else
      printf ":: Skipping: %s (not found or invalid)\n" "$item"
    fi
  done
}

# remove files and directories
function rmv() {
    for item in "$@"; do
        if [[ -f "$item" ]]; then
            printf ":: Removing a file\n"
            rm "$item"
        elif [[ -d "$item" ]]; then
            printf ":: Removing a directory\n"
            rm -rf "$item"
        else
            printf "[ !! ]\n$item does not exist or is neither a regular file nor a directory\n"
        fi
    done
}

# disk spaces
function rsc(){
    case $1 in
        __disk)
            disk_total=$(df / -h | awk 'NR==2 {print $2}')
            disk_used=$(df / -h | awk 'NR==2 {print $3}')
            disk_free=$(df / -h | awk 'NR==2 {print $4}')
            printf "Total: $disk_total\nUsed: $disk_used\nFree: $disk_free\n"
            ;;
        __memory)
            mem_total=$(free -h | awk 'NR==2 {print $2}')
            mem_used=$(free -h | awk 'NR==2 {print $3}')
            mem_free=$(free -h | awk 'NR==2 {print $7}')
            printf "Total: $mem_total\nUsed: $mem_used\nFree: $mem_free\n"
            ;;
    esac
}

# check updates
function cu() {
    if [ -n "$(command -v pacman)" ]; then  # Arch Linux
        # Check for updates
        aurhlpr=$(command -v yay || command -v paru)
        aur=$(${aurhlpr} -Qua | wc -l)
        
        ofc=$(checkupdates | wc -l)

        # Calculate total available updates
        upd=$(( ofc + aur ))
        printf "[ UPDATES ]\n:: You have \e[1;32m$upd\e[0m updates available.\n:: Main: $ofc\n:: Aur: $aur\n"
    
    elif [ -n "$(command -v dnf)" ]; then  # Fedora
        upd=$(dnf check-update -q | wc -l)
        printf "[ UPDATES ]\n:: You have \e[1;32m$upd\e[0m updates available\n"

    elif [ -n "$(command -v zypper)" ]; then  # openSUSE
        upd=$(zypper lu --best-effort | grep -c 'v  |')
        printf "[ UPDATES ]\n:: You have \e[1;32m$upd\e[0m updates available\n"

    elif [ -n "$(command -v apt)" ]; then   # debian/ubuntu
        upd=$(apt list --upgradable 2> /dev/null | grep -c '\[upgradable from')
        printf "[ UPDATES ]\n:: You have \e[1;32m$upd\e[0m updates available\n"

    else
        printf "\e[1;31m Unsupported package manager for now, please let us know in the github repository...\e[1;0m \n https://github.com/me-js-bro/Bash\n"
        return 1
    fi
}

# package updates
function update() {
    update_success=0
    network_error=0

    if [ -n "$(command -v pacman)" ]; then  # Arch Linux
        aur=$(command -v yay || command -v paru) # find the aur helper
        $aur -Syyu --noconfirm

    elif [ -n "$(command -v dnf)" ]; then  # Fedora
        sudo dnf update -y && sudo dnf upgrade -y --refresh
    elif [ -n "$(command -v zypper)" ]; then  # openSUSE
        sudo zypper ref && sudo zypper up -y
    elif [ -n "$(command -v apt)" ]; then  # Debian/Ubuntu
        sudo apt update -y && sudo apt upgrade -y
    else
        printf "\e[1;31m Unsupported package manager for now, please let us know in the github repository...\e[1;0m \n https://github.com/me-js-bro/Bash\n"
        return 1
    fi
}

# Install software
function install() {

    if [ -n "$(command -v pacman)" ]; then  # Arch Linux

        pkg_manager=$(command -v pacman || command -v yay || command -v paru)
        aur=$(command -v yay || command -v paru) # find the aur helper

        $aur -S --noconfirm "$@"

    elif [ -n "$(command -v dnf)" ]; then  # Fedora

        sudo dnf install -y "$@"

    elif [ -n "$(command -v zypper)" ]; then  # openSUSE

        sudo zypper in -y "$@"

    elif [ -n "$(command -v apt)" ]; then  # Ubuntu or Ubuntu-based

        sudo apt install -y "$@"

    else
        printf "\e[1;31m Unsupported package manager for now, please let us know in the GitHub repository...\e[1;0m \n https://github.com/me-js-bro/Bash\n"
        return 1
    fi
}

# package install
function remove() {
    if [ -n "$(command -v pacman)" ]; then  # Arch Linux
    
        pkg_manager=$(command -v pacman || command -v yay || command -v paru)
        aur=$(command -v yay || command -v paru)
        "$aur" -Rns "$@"

    elif [ -n "$(command -v dnf)" ]; then  # Fedora

        sudo dnf remove "$@"

    elif [ -n "$(command -v zypper)" ]; then  # openSUSE

        sudo zypper rm "$@"

    elif [ -n "$(command -v apt)" ]; then  # ubunt or related

        sudo apt remove "$@"

    else
        printf "\e[1;31m Unsupported package manager for now, please let us know in the github repository...\e[1;0m \n https://github.com/me-js-bro/Bash\n"
        return 1
    fi
}

# compile cpp file with gcc
function cpp() {
    filename="$1"
    if [ -n "$(command -v g++)" ]; then
        printf "\e[0;36m[ * ] - Compiling...!\e[0m\n\n"

        if g++ -std=c++20 "$filename".cpp -o "$filename"; then
            printf "\e[1;92m[ ✓ ] - Successfully compiled your code...!\e[0m\n"
            if [[ "$2" == "-o" ]]; then
                printf "\e[1;92m        Output: \e[0m\n\n" 
                ./$filename
            fi
        else
            printf "\n\e[1;91m[  ] - Error: Could not compile your code...!\e[0m\n"
        fi
    fi
}

# Prints random height bars across the width of the screen
# (great with lolcat application on new terminal windows)
function random_bars() {
	columns=$(tput cols)
	chars=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)
	for ((i = 1; i <= $columns; i++))
	do
		echo -n "${chars[RANDOM%${#chars} + 1]}"
	done
	echo
}

# y shell wrapper that provides the ability to change the current working directory when exiting Yazi.
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
