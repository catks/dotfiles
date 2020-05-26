# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
#ZSH_THEME="catks"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ruby docker bundler fasd zsh-completions zsh-autosuggestions zsh-syntax-highlighting)
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh
#source ~/.bin/tmuxinator.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export PATH="$HOME/.rbenv/bin:/home/linuxbrew/.linuxbrew/bin:$PATH"
alias starwars="telnet towel.blinkenlights.nl"

eval "$(rbenv init -)"
export EDITOR=nvim
alias vim='nvim'
alias v='f -e vim'
alias gmlb='git merge @{-1}'
alias gptp='git push --tags && git push'
alias gdc='git diff --cached'
alias gclb='git checkout -'
alias gp!='git push --force'
alias dcm='docker-compose'
alias rubocop_branch='git diff --name-only origin/master `git rev-parse --abbrev-ref HEAD` | grep '\.rb' | xargs rubocop --force-exclusion'
alias upgrade='sudo apt update && sudo apt upgrade'

# Set Spaceship ZSH as a prompt
#autoload -U promptinit; promptinit
#prompt Spaceship
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=238

export PATH=$PATH:/$HOME/.bin
bindkey '^ ' autosuggest-toggle
(cd ~ && rsync -a .zshrc .my_functions.sh .vimrc projetos/dotfiles/)
#source ~/.my_functions.sh
# (cd ~ && for f in .*.env;do source .vagas.env;done)
alias djin='RBENV_VERSION=2.6.5 djin'
alias verto='docker run -v ~/.gitconfig:/etc/gitconfig -v $(pwd):/usr/src/project -v $HOME/.ssh/known_hosts:/root/.ssh/known_hosts -v $HOME/.ssh/id_rsa:/root/.ssh/id_rsa -e SSH_PRIVATE_KEY=/root/.ssh/id_rsa -it catks/verto:0.8.0'
alias djin='RBENV_VERSION=2.5.1 djin'
alias vagas_rollback='RBENV_VERSION=2.5.1 vagas_rollback'
alias aell='RBENV_VERSION=2.5.1 aell'
