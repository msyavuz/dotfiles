# .dotfiles

These are my dotfiles managed by [GNU Stow](https://www.gnu.org/software/stow/)

## Installation

1. Install GNU Stow

Arch: 

```bash
sudo pacman -S stow
```

2. Clone this repository to your home directory (i use .dotfiles as the name of the directory)

```bash
git clone https://github.com/msyavuz/dotfiles.git .dotfiles
```

3. Stow what you like using directory names

```bash
stow hypr
```
> [!NOTE]
> Stow won't work if the file already exists.
