## My DWM Config + Install script

### Install (If you want to for some reason)
```
git clone "https://github.com/eternalblissed/DWM-Install"
cd DWM-Install
chmod +x ./install.sh
./install.sh
```
## Please note
- This is tailored for me, there will be bloat.
- This is catppuccin themed by default.
- This script has only been tested with an archinstall minimal profile installed with no audio driver selected.
- I highly, highly recommend forking this and modding it to your liking.
- If you fork it, you should expect to deal with c and bash.
- This is not finished, there will be bugs, missing features and more

## Screenshots
![Screenshot](https://i.ibb.co/48s2z9g/Screenshot-2024-01-21-16-31-35.png)
![Screenshot](https://i.ibb.co/px4CS4B/Screenshot-2024-01-21-17-57-14.png)

## List of all programs & optional programs

### Arch Linux Official Repositories (via pacman):
- `xfce4-screenshooter`
- `j4-dmenu-desktop`
- `upower`
- `gvfs`
- `pulseaudio`
- `pulseaudio-alsa`
- `pulseaudio-jack`
- `pulseaudio-zeroconf`
- `pulseaudio-bluetooth`
- `nano`
- `thunar`
- `mpv`
- `dconf`
- `dunst`
- `zsh`
- `xorg-xrandr`
- `brightnessctl`
- `bluez`
- `blueman`
- `hsetroot`
- `sxhkd`
- `picom`
- `ttf-jetbrains-mono`
- `network-manager-applet`
- `xorg-xsetroot`
- `pavucontrol`
- `python-setuptools`
- `xorg-server`
- `xorg-xinit`
- `zsh-completions`
- `nvidia-dkms` (optional, for Nvidia GPU)

### AUR (Arch User Repository) via Trizen:
- `vscodium-bin` (optional)
- `obsidian-bin` (optional)
- `screenfetch` (optional)
- `rustup` (optional)
- `go` (optional)
- `audacity` (optional)
- `btop` (optional)
- `cava` (optional)
- `intel-ucode` (optional)
- `neovim` (optional)
- `nasm` (optional)
- `docker` (optional)
- `docker-compose` (optional)
- `tree` (optional)
- `pacman-contrib` (optional)
- `nodejs` (optional)
- `npm` (optional)
- `unzip` (optional)
- `catppuccin-gtk-theme-mocha`
- `papirus-icon-theme-git`
- `adwaita-cursors-git`
- `librewolf-bin` (with `--skipinteg`)
- `python-pulsectl`
- `volctl`

### Other Installations and Configurations:
- DWM window manager (from a local repository)
- DMenu (from a local repository)
- Simple Terminal (ST) (from a local repository)
- Configuration for `sxhkd`, `dunst`, `btop`, `cava`
- Configuration for `GTK` settings
- Installation of `Oh My Zsh` for `zsh` customization (WIP)

### Note:
- The script also performs system updates, service enablement, directory creation, file copying, and other configurations that are not package installations per se.


## Keybinds

| Key Combination | Action |
|-----------------|--------|
| XF86XK_MonBrightnessUp | Increase monitor brightness |
| XF86XK_MonBrightnessDown | Decrease monitor brightness |
| MODKEY + p | Spawn dmenu |
| MODKEY + Enter | Spawn terminal |
| MODKEY + b | Toggle status bar |
| MODKEY + j | Focus next window |
| MODKEY + k | Focus previous window |
| MODKEY + i | Increase number of master windows |
| MODKEY + d | Decrease number of master windows |
| MODKEY + h | Decrease master area size |
| MODKEY + l | Increase master area size |
| MODKEY + Tab | Switch to last tag |
| MODKEY + q | Close focused window |
| MODKEY + t | Tile layout |
| MODKEY + f | Floating layout |
| MODKEY + m | Monocle layout |
| MODKEY + space | Cycle through layouts |
| MODKEY + Shift + space | Toggle floating on focused window |
| MODKEY + 0 | View all tags |
| MODKEY + Shift + 0 | Apply current tag to all windows |
| MODKEY + comma | Focus previous monitor |
| MODKEY + period | Focus next monitor |
| MODKEY + Shift + comma | Move window to previous monitor |
| MODKEY + Shift + period | Move window to next monitor |
| MODKEY + minus | Decrease gaps between windows |
| MODKEY + equal | Increase gaps between windows |
| MODKEY + Shift + equal | Reset gaps to default |
| MODKEY + Shift + q | Quit dwm |
| TAGKEYS(XK_1) | View tag 1 |
| TAGKEYS(XK_2) | View tag 2 |
| TAGKEYS(XK_3) | View tag 3 |
| TAGKEYS(XK_4) | View tag 4 |
| TAGKEYS(XK_5) | View tag 5 |
| TAGKEYS(XK_6) | View tag 6 |
| TAGKEYS(XK_7) | View tag 7 |
| TAGKEYS(XK_8) | View tag 8 |
| TAGKEYS(XK_9) | View tag 9 |

