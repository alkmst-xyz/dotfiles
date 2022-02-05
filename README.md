# My Personal Setup

## Configs

- NeoVim
- ZSH
- Starship Prompt
- Alacritty

## Installing

- You will need `git` and GNU `stow`.
- Clone into your `$HOME` directory.

```bash
git clone https://github.com/josephsv96/dotfiles.git ~
cd dotfiles
```

- Run `stow` to symlink everything or just select what you want.

```bash
stow zsh    # Just my zsh config
```

```bash
stow */     # Everything (the '/' ignores the README)
```

## Adding dotfiles

- The dotfiles folder mirrors the structure of the `$HOME` directory.
- In order to manage configuration using `stow`, **_move_** those dotfiles into new folders with their name as an identifier.
- Now, within `~/dotfiles`, run `stow`.

```sh
# E.g: move alacritty config to your source controlled dotfiles 
folder and create symbolic links for them in your home directory.
# alacritty config is located in ~/.config/alacritty/alacritty.yml 
mkdir -p ~/.dotfiles/alacritty/.config
mv ~/.config/alacritty ~/.dotfiles/alacritty/.config
cd ~/.dotfiles
stow alacritty
ls -la ~/.config | grep alacritty
```

## References

1. [Machfiles](https://github.com/ChristianChiarulli/Machfiles)
