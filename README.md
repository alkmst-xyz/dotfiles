# dotfiles

> Tested on Fedora Linux 44.

## Install

```bash
stow tmux   # Just tmux config
stow .      # All configs
```

## Software

| Name | Version |
| ---- | ------- |
| nvim | 0.12.3  |
| lf   | r41     |

### `nvim`

- Install `nvim` as an AppImage from
  [neovim releases](https://github.com/neovim/neovim/releases).
- Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

```bash
curl -LO https://github.com/neovim/neovim/releases/download/v0.12.3/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
mv nvim-linux-x86_64.appimage ~/.local/bin/nvim

# Install external dependencies.
sudo dnf install ripgrep fd-find tree-sitter-cli
```

<!--
Shortcuts:

- `<Leader>` : menu
- `<Leader> + e` : open explorer
- `<Leader> + l + f` : run formatter
- `<Leader> + p + u` : packer update to update plugins
- `g + l` : get diagnostics
- `g + r` : get references to a function/variable
- `g + d` : get definition
- `<Leader> + f` : find file
- `<Leader> + F` : find specific word using grep
- `<Leader> + t` : start terminal
- `Ctrl + h/j/k/l` : better window navigation
- `Shift + H/L` : move between text buffers (left and right)
- `jk` : quickly press to go to normal mode from insert mode
- `<` and `>` : indent selected text (visual mode)
- `Alt +j/k` : move selected text (visual mode)
-->

### `tmux`

```bash
# install tpm
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

<!--
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
-->
