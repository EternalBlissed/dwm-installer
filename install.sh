#! /bin/bash
set -e

# Create necessary directories and copy the wallpaper
mkdir -p $HOME/.config/
sudo mkdir -p /usr/share/backgrounds/cnzn/
sudo cp wallpaper/wallpaper.jpg /usr/share/backgrounds/cnzn/wallpaper.jpg

# Update the system and install necessary packages
sudo pacman -Syu
sudo pacman -S rofi upower gvfs pulseaudio pulseaudio-alsa pulseaudio-jack pulseaudio-zeroconf  pulseaudio-bluetooth nano thunar mpv dconf dunst zsh xorg-xrandr brightnessctl bluez blueman hsetroot sxhkd picom ttf-jetbrains-mono network-manager-applet xorg-xsetroot pavucontrol python-setuptools xorg-server xorg-xinit zsh-completions

# Enable and start necessary services
sudo systemctl enable bluetooth NetworkManager upower
sudo systemctl start bluetooth NetworkManager upower

# Prepare for AUR package installation
mkdir -p AURPackages
cd AURPackages
git clone https://aur.archlinux.org/trizen
cd trizen && makepkg -si

# Prompt for optional tool installation
clear
echo "Would you like to install extra tools (vscodium, obsidian-bin, screenfetch, rustup, go, audacity, btop, intel-ucode, neovim, nasm, docker, docker-compose, tree, pacman-contrib, nodejs, npm, unzip)? (y/n)"
read -r install_extra

if [ "$install_extra" = "y" ]; then
    trizen -S vscodium-bin obsidian-bin screenfetch rustup go audacity btop intel-ucode neovim nasm docker docker-compose tree pacman-contrib nodejs npm unzip
fi

clear
# Prompt for optional tool installation
echo "Do you have a nvidia GPU? (y/n)"
read -r install_gpu

if [ "$install_gpu" = "y" ]; then
    sudo pacman -S nvidia-dkms
fi

# Continue with other installations
trizen -S catppuccin-gtk-theme-mocha papirus-icon-theme-git adwaita-cursors-git
trizen -S --skipinteg librewolf-bin

cd ../
git clone https://aur.archlinux.org/python-pulsectl.git
cd python-pulsectl && makepkg -si

cd ../
git clone https://aur.archlinux.org/volctl.git
cd volctl && makepkg -si

# Install window manager and related tools
cd ../../dwm && sudo make install
sudo make clean

cd ../dmenu && sudo make install
sudo make clean

cd ../st && sudo make install
sudo make clean

# Configure sxhkd and dunst
cd ../ && cp -r sxhkd/ $HOME/.config/ 
cp -r dunst/ $HOME/.config/
chmod +x $HOME/.config/dunst/launch.sh

# Set up .xinitrc
cd $HOME && touch .xinitrc
echo 'exec dwm
xrandr --output eDP-1 --mode 1920x1080
xrandr --output DP-1 --mode 1920x1080 --right-of eDP-1
$HOME/.config/dunst/launch.sh
' > .xinitrc 


# Configure GTK settings
mkdir ~/.config/gtk-3.0
echo '[Settings]
gtk-theme-name=Catppuccin-Mocha-Standard-Lavender-Dark
gtk-icon-theme-name=Papirus-Dark
gtk-font-name=Cantarell 11
gtk-cursor-theme-name=Adwaita
gtk-cursor-theme-size=0
gtk-toolbar-style=GTK_TOOLBAR_BOTH
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=1
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintfull' > ~/.config/gtk-3.0/settings.ini

# Clean up package cache
trizen -Scc

echo "Finished, Please Reboot after changing your shell"

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set up .zshrc
echo 'alias codium=code
alias nvim=vim
' > .zshrc
