#! /bin/bash
set -e

#!/bin/bash

cat <<'EOF'
      ..      .          s                                                            ..    .x+=:.             ....               ...    .     ...          ...     ..      ..     
   x88f` `..x88. .>     :8                                                      x .d88"    z`    ^%        .xH888888Hx.        .~`"888x.!**h.-``888h.     x*8888x.:*8888: -"888:   
 :8888   xf`*8888%     .88                  .u    .      u.    u.                5888R        .   <k     .H8888888888888:     dX   `8888   :X   48888>   X   48888X `8888H  8888   
:8888f .888  `"`      :888ooo      .u     .d88B :@8c   x@88k u@88c.       u      '888R      .@8Ned8"     888*"""?""*88888X   '888x  8888  X88.  '8888>  X8x.  8888X  8888X  !888>  
88888' X8888. >"8x  -*8888888   ud8888.  ="8888f8888r ^"8888""8888"    us888u.    888R    .@^%8888"     'f     d8x.   ^%88k  '88888 8888X:8888:   )?""` X8888 X8888  88888   "*8%- 
88888  ?88888< 888>   8888    :888'8888.   4888>'88"    8888  888R  .@88 "8888"   888R   x88:  `)8b.    '>    <88888X   '?8   `8888>8888 '88888>.88h.   '*888!X8888> X8888  xH8>   
88888   "88888 "8%    8888    d888 '88%"   4888> '      8888  888R  9888  9888    888R   8888N=*8888     `:..:`888888>    8>    `8" 888f  `8888>X88888.   `?8 `8888  X888X X888>   
88888 '  `8888>       8888    8888.+"      4888>        8888  888R  9888  9888    888R    %8"    R88            `"*88     X    -~` '8%"     88" `88888X   -^  '888"  X888  8888>   
`8888> %  X88!       .8888Lu= 8888L       .d888L .+     8888  888R  9888  9888    888R     @8Wou 9%        .xHHhx.."      !    .H888n.      XHn.  `*88!    dx '88~x. !88~  8888>   
 `888X  `~""`   :    ^%888*   '8888c. .+  ^"8888*"     "*88*" 8888" 9888  9888   .888B . .888888P`        X88888888hx. ..!    :88888888x..x88888X.  `!   .8888Xf.888x:!    X888X.: 
   "88k.      .~       'Y"     "88888%       "Y"         ""   'Y"   "888*""888"  ^*888%  `   ^"F         !   "*888888888"     f  ^%888888% `*88888nx"   :""888":~"888"     `888*"  
     `""*==~~`                   "YP'                                ^Y"   ^Y'     "%"                           ^"***"`            `"**"`    `"**""         "~'    "~        ""    
EOF

# Warning message and proceed prompt
echo "WARNING: This script has only been tested with an archinstall minimal profile with no audio driver selected. Proceed with caution."
echo "Do you want to proceed? (y/n)"
read -r proceed

if [ "$proceed" != "y" ]; then
    echo "Script aborted."
    exit 1
fi

# Create necessary directories and copy the wallpaper
mkdir -p $HOME/.config/
sudo mkdir -p /usr/share/backgrounds/eternals-dwm/
sudo cp wallpaper/wallpaper.jpg /usr/share/backgrounds/eternals-dwm/wallpaper.jpg

# Update the system and install necessary packages
sudo pacman -Syu
sudo pacman -S xfce4-screenshooter j4-dmenu-desktop upower gvfs pulseaudio pulseaudio-alsa pulseaudio-jack pulseaudio-zeroconf pulseaudio-bluetooth nano thunar mpv dconf dunst zsh xorg-xrandr brightnessctl bluez blueman hsetroot sxhkd picom ttf-jetbrains-mono network-manager-applet xorg-xsetroot pavucontrol python-setuptools xorg-server xorg-xinit zsh-completions

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
echo "Would you like to install extra tools (vscodium, obsidian-bin, screenfetch, rustup, go, audacity, btop, intel-ucode, neovim, nasm, docker, docker-compose, tree, pacman-contrib, nodejs, npm, unzip, vesktop)? (y/n)"
read -r install_extra

if [ "$install_extra" = "y" ]; then
    trizen -S vscodium-bin obsidian-bin screenfetch rustup go audacity btop cava intel-ucode neovim nasm docker docker-compose tree pacman-contrib nodejs npm unzip vesktop-bin
    cp -r ../btop/ $HOME/.config/
    cp -r ../cava/ $HOME/.config/
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
trizen -S --skipinteg floorp-bin

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

# Create a .desktop file for st
mkdir -p $HOME/.local/share/applications/
echo '[Desktop Entry]
Type=Application
Name=Simple Terminal (st)
Comment=Simple Terminal (st)
Exec=st
Terminal=false
Categories=System;TerminalEmulator;' > $HOME/.local/share/applications/st.desktop

update-desktop-database $HOME/.local/share/applications/

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
sudo pacman -Rns $(pacman -Qdtq)

echo "Finished, Please Reboot after changing your shell"

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set up .zshrc
echo 'alias codium=code
alias nvim=vim
' > .zshrc
