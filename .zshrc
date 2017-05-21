# Path to your oh-my-zsh installation.
export ZSH=/Users/hiroki/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

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
plugins=(git)

# User configuration

export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

source $ZSH/oh-my-zsh.sh

export M3_HOME='/usr/local/Cellar/maven-deluxe/3.3.9-7'
export JAVA_HOME=$(/usr/libexec/java_home)

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

alias me='sudo chown $(whoami):admin'

alias ports='netstat -tulanp'
alias ipt='sudo /sbin/iptables'
alias reboot='sudo reboot'
alias poweroff='sudo poweroff'
alias halt='sudo halt'
alias shutdown='sudo shutdown -h now'
alias bye='sudo shutdown -h now'
alias psg='ps aux | grep '
alias psmem='ps aux | sort -nr -k 4'
alias psmem10='ps aux | sort -nr -k 4 | head -10'
alias pscpu='ps aux | sort -nr -k 3'
alias pscpu10='ps aux | sort -nr -k 3 | head -10'
alias df='df -H'
alias du='du -ch'

function s() {
  screen -t vim
  $1
}

# For C/C++
alias vg="valgrind"
alias vgl="valgrind --leak-check=full"
alias vglt="valgrind --leak-check=full --track-origins=yes"

# For Java
alias test='mvn test'
alias testx='mvn -X test'

# For Python envs (mostly)
alias sa='source activate'
alias sd='source deactivate'
alias sac='source ~/envs/canopy/bin/activate'

# For Jupyter
alias jn="jupyter notebook"
alias jc='jupyter nbconvert --to script'

# For NPM
alias ni='npm install'
alias nig='npm install -g'
alias nis='npm install --save'
alias nid='npm install --save-dev'
alias ns='npm start'
alias nb='npm build'

# For Matlab
alias ml='matlab -nodesktop'

# For Git
alias gr='git revert --no-edit'
alias gc='git clone'
alias gst='git status'
alias gstash='git stash -save "temporary stashed"'
alias gss='git stash show'
alias gsl='git stash list'
alias gsp='git stash pop'
alias gbr='git branch'
alias gco='git checkout'
alias gcom='git checkout master'
alias gcoq='git checkout qa'
alias gci='git commit -m'
alias gcia='git add . && git commit -m'
alias glog='git log --oneline'
alias gdiff='git diff'
alias greset='git reset --soft HEAD~ && git status'
alias gbm='git blame'
function gsquash() { git rebase -i HEAD~$1 }
function gss_at() { git stash show stash@{$1} }

# For Rails
alias b='bundle exec'
alias r='bundle exec rake'

# Set up aliases for directory listing shortcuts.
alias ls='ls -F'
if [ -n $CS_SYS5 ]; then
  alias ls='ls -aFC'
fi
alias ll='ls -lG'
alias l='ls -o'
alias la='ls -la'

# Set up aliases to list paths vertically, element by element, rather than horizontally across the screen. 
alias path='echo $PATH | tr -s ":" "\n"'
alias manpath='echo $MANPATH | tr -s ":" "\n"'

# Shows how much disk space you are using (and where). Then shows how much you are allocated.
alias diskuse='du -k ~/ | sort -n ; echo " " ; quota -v'

function rename() { ls | sed -n $1 | sh }

eval "$(rbenv init -)"

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
