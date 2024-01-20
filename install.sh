#! /bin/bash
set -e

mkdir -p $HOME/.config/
sudo mkdir -p /usr/share/backgrounds/cnzn/
sudo cp wallpaper/wallpaper.jpg /usr/share/backgrounds/cnzn/wallpaper.jpg

sudo pacman -Syu

sudo pacman -S gvfs pulseaudio pulseaudio-alsa pulseaudio-jack pulseaudio-zeroconf  pulseaudio-bluetooth nano thunar mpv dconf dunst zsh xorg-xrandr brightnessctl bluez blueman hsetroot sxhkd picom ttf-jetbrains-mono network-manager-applet xorg-xsetroot pavucontrol python-setuptools xorg-server xorg-xinit

sudo systemctl enable bluetooth NetworkManager
sudo systemctl start bluetooth NetworkManager

mkdir -p AURPackages
cd AURPackages

git clone https://aur.archlinux.org/trizen
cd trizen && makepkg -si

trizen -S catppuccin-gtk-theme-mocha papirus-icon-theme-git adwaita-cursors-git vscodium-bin screenfetch

trizen -S --skipinteg librewolf-bin

cd ../
git clone https://aur.archlinux.org/python-pulsectl.git
cd python-pulsectl && makepkg -si

cd ../
git clone https://aur.archlinux.org/volctl.git
cd volctl && makepkg -si

# Change from ../dwm to dwm if above is commented out
cd ../dwm && sudo make install
sudo make clean

cd ../st && sudo make install
sudo make clean

cd ../dmenu && sudo make install
sudo make clean

cd ../ && cp -r sxhkd/ $HOME/.config/ 

cp -r dunst/ $HOME/.config/

chmod +x $HOME/.config/dunst/launch.sh

cd $HOME && touch .xinitrc
echo 'exec dwm
./$HOME/.config/dunst/launch.sh
xrandr --output eDP-1 --mode 1920x1080
xrandr --output DP-1 --mode 1920x1080 --right-of eDP-1
' > .xinitrc 

echo 'alias codium=code
alias nvim=vim
' > .zshrc

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
trizen -Scc

echo "Finished, Please Reboot after changing your shell"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
