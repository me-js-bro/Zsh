<h1 align="center">Custom zsh</h1>

## Features
- Custom functions and alias
- Better `ls` with `eza`
- Better `cd` with `zoxide`
- Better `cat` with `bat`
- Fuzzy finding with `fzf` and preview with `bat`
- Command mistake correction with `thefu*k`
- Minimal powerlevel10k theme
- Syntax highlighting
- Auto suggestions

## Installation
just run the commands below. and it will automaticly install `zsh`, `oh-my-zsh`, `zsh-syntaxhighlightine`, `zsh-autosuggestions`, `powerlevel10k` and other necessary packages. Also you will get some custom funstions and alias. But for now, it only supports <i>only <strong>4</strong> package managers</i>. Soon I will add more. And also for <strong>brew</strong> in MacOs.<br>
```
git clone --depth=1 https://github.com/me-js-bro/Zsh.git && cd Zsh
chmod +x install.sh
./install.sh
```


## Command Shortcuts

### 1) Directory Navigation and File Management

| Shortcut | Command | Description |
|----------|---------|-------------|
| `cu`     | `paru/yay -Qua / checkupdates`, `sudo dnf check-update` or `sudo zypper list-updates`  | Checks system updates (Arch, Fedora, OpenSuse. Also prints both Official and Aur updates in Arch Linux). |
| `update`     | `paru/yay -Syyu`, `sudo dnf upgrade`, `sudo zypper update`, or `sudo apt-get update` | Updates the system packages (Arch, Fedora, OpenSuse, Debian/Ubuntu). |
| `install`     | `paru/yay -S`, `sudo dnf install`, `sudo zypper install`, or `sudo apt-get install` | Install package (Arch, Fedora, OpenSuse, Debian/Ubuntu). |
| `remove`     | `paru/yay -Rns`, `sduo dnf remove`, `sudo zypper remove`, or `sudo apt-get remove` | Uninstall package (Arch, Fedora, OpenSuse, Debian/Ubuntu). |
| `add`     | `git add .`         | Add. |
| `clone`     | `git clone`         | Clone a repository. |
| `cloned`    | `git clone --depth=1` | Clone a repository with depth 1. |
| `commit`    | `git commit -m`     | Commit with a message. |
| `push`     | `git push`          | Push changes to the remote repository. |
| `pushm`    | `git push -u origin main` | Push changes and set upstream to main. |
| `pusho`    | `git push origin [branch]` | Push to a specified branch. |
| `pull`    | `git pull origin [branch]` | Pull from a specified branch. |
| `info`    | `git info` | Git Information. |

