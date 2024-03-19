# Arch Linux dotfiles

## Overview

**OS**: Arch Linux

**WM**: [Dwm](https://github.com/siuyutpang/dwm)

**Bar**: [slstatus](https://github.com/siuyutpang/slstatus)

**Compositor**: [picom](https://github.com/FT-Labs/picom) (ftlabs's fork)

**Shell**: zsh

**Prompt**: starship

**Terminal**: alacritty

**Editor**: [neovim](https://github.com/siuyutpang/nvim) and vscode

**Fonts**: Monaco, Fantasque Sans Mono, LXGW WenKai Mono

**Wallpaper tool**: feh

**Wallpaper source**: [Studio Ghibli](https://www.ghibli.jp/info/013381/)

**Screenshot tool**: flameshot

**RSS reader**: newsboat

**File manager**: ranger and dolphin

settings for:

- shell
  - zsh
  - bash
  - fish
  - starship

- terminal emulator
  - kitty
  - wezterm
  - alacritty

- terminal multiplexer
  - tmux
  - zellij

- dev related
  - gdb
  - npm
  - pip
  - mycli
  - python
  - vscode
  - gnupg
  - git

- misc
  - sxhkd
  - mpv
  - yt-dlp
  - aria2
  - font
  - fcitx5
  - ranger
  - newsboat
  - translate-shell

To be continued

## Setup

1. Clone repo

```bash
git clone --bare https://github.com/siuyutpang/dotfiles.git $HOME/.dotfiles
alias dfm='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
dfm checkout
dfm config --local status.showUntrackedFiles no
```

If you already having some dotfiles, you can use following commands to backup them.
```bash
mkdir -p ~/.dotfiles-backup
dfm checkout 2>&1 \
    | grep -E '\s+\.' \
    | awk '{print $1}' \
    | xargs -I{} mv {} ~/.dotfiles-backup/{}
```

2. Config shell

use znap as zsh plugins manager. comparing to others, such as zinit, zplug, Is's really fast, light-weight and easy to use.

```bash
mkdir ~/.local/share/znap
git clone --depth 1  https://github.com/marlonrichert/zsh-snap.git ~/.local/share/znap/zsh-snap
```

3. Install dependencied

```bash
sudo pacman -S \
starship zsh-completions \
fzf atuin zoxide direnv

yay -S asdf-vm
```

## Recommendation

some awesome CLI tools
```
ripgrep fd viddy zellij
bat jq yq xsv viu tldr dog htop
pv moreutils
```
