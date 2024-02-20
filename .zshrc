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

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if command -v nom &> /dev/null
then
  nom_lines=$(nom list | wc -l)
  nom_unread=$(($nom_lines / 2))
  #echo "\033[0;33m$nom_unread unread posts in nom."
  echo "\033[1;33m\n$nom_unread unread posts in nom."
fi

export PATH="$HOME/.tgenv/bin:$HOME/go/bin:$PATH"
