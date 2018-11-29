#!/bin/bash
install(){
  echo "---------------------------------------------------------------------------------"
  echo "Installing $1"
  eval $2
  echo "Done"
  echo "---------------------------------------------------------------------------------"
}
install "Homebrew" '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
install "zsh-auto-suggestions..." 'git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions'
install "zsh-syntax-highlighting" 'brew install zsh-syntax-highlighting'
install "zsh-completions" 'git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions'
install "rbenv" 'brew install rbenv'
# TODO: Adds Tmux installation
install "TPM" 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm'
install "FZF" 'brew install fzf'
install 'htop' 'brew install htop'
install 'ctop' 'brew install ctop'
install 'ag' 'brew install ag'



