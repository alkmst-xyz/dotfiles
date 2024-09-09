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

## Adding a config

- A 'dotfiles' folder of an application mirrors the structure of the `$HOME` directory.
- To manage an app's config files using `stow`, **_move_** the files to a new folder with the app's name in the root level.
- Now, within `dotfiles`, run `stow`.

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

## Deleting a config

- When deleting symbolic links from the config folder, don't include a trailing slash.
- This will delete the contents inside the parent location.
- [Ref](https://serverfault.com/questions/371731/cant-delete-symbolic-link).

## zsh

### Adding Completions for Docker and zsh

```bash
wget https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker -O /usr/ _docker
sudo mv _docker /usr/share/zsh/site-functions/
```

### Update zsh plugins

```bash
cd zsh/.config/zsh/extra
for d in ./*/ ; do (cd "$d" && git pull); done
```

## tmux

```bash
# install tpm
cd .dotfiles/
./tmux/.config/tmux/install-tpm.sh
tmux source ~/.config/tmux/tmux.conf

# install plugins
tmux

# `prefix + I`
#
# - Installs new plugins from GitHub or any other git repository
# - Refreshes TMUX environment

# `prefix + U`
#
# - updates plugin(s)
```


## References

1. [Machfiles](https://github.com/ChristianChiarulli/Machfiles)
