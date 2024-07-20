# dotfiles

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

## Adding Completions for Docker and zsh

```shell
wget https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker -O /usr/ _docker
sudo mv _docker /usr/share/zsh/site-functions/
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

## Update zsh plugins

```bash
cd zsh/.config/zsh/extra
for d in ./*/ ; do (cd "$d" && git pull); done
```

## Deleting config

- When deleting symbolic links from the config folder, don't include a trailing slash.
- This will delete the contents inside the parent location.
- [Ref](https://serverfault.com/questions/371731/cant-delete-symbolic-link).

## References

1. [Machfiles](https://github.com/ChristianChiarulli/Machfiles)
