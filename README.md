# My Personal Setup

## Configs

- NeoVim
- ZSH
- Starship Prompt
- Alacritty

## Installing

- You will need `git` and GNU `stow`
- Clone into your `$HOME` directory or `~`

```bash
git clone https://github.com/josephsv96/dotfiles.git ~
```

- Run `stow` to symlink everything or just select what you want.

```bash
stow */     # Everything (the '/' ignores the README)
```

```bash
stow zsh    # Just my zsh config
```

## References

1. [Machfiles](https://github.com/ChristianChiarulli/Machfiles)
