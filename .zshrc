export ZSH=/Users/hadrianhughes/.oh-my-zsh

export ZSH_2000_DISABLE_RVM='true'

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
source $(brew --prefix nvm)/nvm.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias dc="docker-compose"
alias detach="tmux detach"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

echo "\n\n\n"
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.tgenv/bin:$HOME/go/bin:$PATH"
