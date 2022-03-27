# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/joseph/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# CUDA
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# Deno
export DENO_INSTALL="/home/joseph/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# nvm 
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# gradle
export PATH=$PATH:/opt/gradle/gradle-7.4.1/bin
# End of PATH


# Aliases
alias ll="ls -la"
alias vim=nvim
# alias code=codium

# Plugins
source ~/.config/zsh/key-bindings.zsh
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 

# Starship prompt
eval "$(starship init zsh)"

# fetch
# pfetch

# wttr
# curl --max-time 0.20 'wttr.in/Rosenheim?format=%l:+%c+%t+(%f)+%h+%w+%m+%D+%z+%d\n'
