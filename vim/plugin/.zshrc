# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="simple"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse vi-mode)
plugins=(bundler brew osx rails git ruby vi-mode)

source $ZSH/oh-my-zsh.sh

export GIT_EDITOR="vim"
export EDITOR="vim"

export HISTCONTROL=erasedups
export HISTSIZE=10000
export SAVEHIST=5000
export HISTFILE=~/.zshistory

alias bs='bundle install --path .bundle/gems --binstubs .bundle/bin'

bindkey "^R" history-incremental-search-backward

#export RSPEC=true
export AUTOFEATURE=true

alias rspec='nocorrect rspec'
alias autotest='nocorrect autotest'
alias rake "noglob rake"

# git aliases
alias gadd="git add -u && git add . && git status"
alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gd='git diff | vim'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gsa='git submodule foreach git pull origin master'
alias gph='git push heroku master'

# projects
alias heav='cd ~/Work/Heavies'
alias ciab='cd ~/Work/coach/coach_in_a_box'
alias shad='cd ~/Work/coach/ciab_shadow_of_the_leader'
alias meth='cd ~/Work/methods/methods_stethoscope_rails'
alias da='cd ~/Work/Hounslow/digitalalpha'

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:$PATH

eval "$(rbenv init -)"
