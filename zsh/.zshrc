# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
# End of lines added by compinstall

# completions
zstyle ':completion:*' menu select                                   # completions menu
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'               # match small case to small/capital
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}%B%d%b%f' # descriptions are bold green
fpath=($HOME/.config/zsh/extra/zsh-completions/src $fpath)           # additional completions

# plugins and key bindings
source $HOME/.config/zsh/extra/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.config/zsh/extra/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.config/zsh/extra/zsh-history-substring-search/zsh-history-substring-search.zsh
source $HOME/.config/zsh/extra/k/k.sh
source $HOME/.config/zsh/key-bindings.zsh

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# CUDA
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# gradle
export PATH=$PATH:/opt/gradle/gradle-7.4.1/bin

# End of PATH

# Aliases
alias ll="ls -la"
alias vim=nvim

# Starship prompt
eval "$(starship init zsh)"

# set nvim as default editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# golang
export PATH=$PATH:$HOME/.local/go/bin
