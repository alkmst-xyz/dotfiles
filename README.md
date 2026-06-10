# dotfiles

## Install

```bash
stow tmux   # Just tmux config
stow .      # All configs
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

## Software

| Name | Version |
| ---- | ------- |
| lf   | r41     |

## `tmux`

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
