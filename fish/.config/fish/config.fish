if status is-interactive
    # Commands to run in interactive sessions can go here
end

# add user specific path
fish_add_path $HOME/.local/bin/

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

# pnpm
set -gx PNPM_HOME "/home/joseph/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# pyenv
set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin
pyenv init - | source

# golang
fish_add_path $HOME/.local/go/bin

# disable greeting
set -g fish_greeting

# abbreviations
abbr -a -- vim nvim
abbr -a -- ll ls -la 

# set nvim as default editor
set -gx EDITOR nvim

# starship
starship init fish | source

# end
