## Zsh Installation Script

### Installation
just run the bellow command, and it will automaticly install `zsh`, `oh-my-zsh`, `zsh-syntaxhighlightine`, `zsh-autosuggestions` and other necessary packages. Also you will get some custom funstions and alias. <br>

Before you run the command, make sure to install `wget`. You can use these commands based on your package manager.
```bash
sudo apt install wget
sudo dnf install wget2
sudo zypper install wget
sudo pacman -S wget
```

### Install Command
```
git clone --depth=1 https://github.com/me-js-bro/Zsh.git
cd Zsh
chmod +x install.sh
./install.sh
```
Just run this command and you are good to go.

## Theme
If you want to change themes of your zsh prompt. Just follow these steps below

- Open your terminal and type `theme`. It will generate oh-my-zsh themes randomly.
- Now copy the name of the theme you liked
- Open `$HOME/.zsh/.zshrc` file with your favourith text editor. and you will find `ZSH_THEME="af-magic"`
- Change the `"af-magic"` with the theme name you copied
- Now type the command `source ~/.zsh/.zshrc` and done...


## Command Shortcuts

### 1) Directory Navigation and File Management

| Shortcut | Command | Description |
|----------|---------|-------------|
| `cd`     | `cd`    | Change directory. If the directory does not exist, it will ask to create it. |
| `downloads`     | `cd ~/Downloads` | Change to the Downloads directory. |
| `pictures`     | `cd ~/Pictures`  | Change to the Pictures directory. |
| `videos`     | `cd ~/Videos`    | Change to the Videos directory. |
| `dir`     | `mkdir`          | Make a directory. |
| `file`     | `touch`          | Create a file. |
| `rm`      | `rm -rf`         | Remove both files and directories. |
| `srm`      | `sudo rm -rf`         | Remove both files and directories with the sudo command |
| `ezsh`   | `code .zsh`    | Open .zsh directory with the vs code to edit  |

### 2) Updated, Install & Uninstall Related

| Shortcut | Command | Description |
|----------|---------|-------------|
| `cu`     | `paru/yay -Qua / checkupdates`, `sudo dnf check-update` or `sudo zypper list-updates`  | Checks system updates (Arch, Fedora, O
penSuse. Also prints both Official and Aur updates in Arch Linux). |
| `update`     | `paru/yay -Syyu`, `sudo dnf upgrade`, `sudo zypper update`, or `sudo apt-get update` | Updates the system packages (Arch, F
edora, OpenSuse, Debian/Ubuntu). |
| `install`     | `paru/yay -S`, `sudo dnf install`, `zypper install`, or `apt-get install` | Install package (Arch, Fedora, OpenSuse, Debia
n/Ubuntu). |
| `remove`     | `paru/yay -Rns`, `sduo dnf remove`, `sudo zypper remove`, or `sudo apt-get remove` | Uninstall package (Arch, Fedora, OpenS
use, Debian/Ubuntu). |

### 3) Git Related

| Shortcut | Command | Description |
|----------|---------|-------------|
| `add`     | `git add .`         | Add. |
| `clone`     | `git clone`         | Clone a repository. |
| `cloned`    | `git clone --depth=1` | Clone a repository with depth 1. |
| `commit`    | `git commit -m`     | Commit with a message. |
| `push`     | `git push`          | Push changes to the remote repository. |
| `pushm`    | `git push -u origin main` | Push changes and set upstream to main. |
| `pusho`    | `git push origin [branch]` | Push to a specified branch. |
| `pull`    | `git pull origin [branch]` | Pull from a specified branch. |
| `info`    | `git info` | Git Information. |

