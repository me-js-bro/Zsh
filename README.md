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