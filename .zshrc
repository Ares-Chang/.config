# oh-my-zsh 安装路径
export ZSH="$HOME/.oh-my-zsh"

# 设置要加载的主题名称，如果设置为 "random"，将会随机加载一个主题
# 如果想要知道当前使用的主题名称，可以运行 echo $ZSH_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME="spaceship"

# zsh 命令修正
# ENABLE_CORRECTION="true"

# -------------------------------------------------- #
# 加载插件
# 标准插件可以在 $ZSH/plugins/ 中找到
# 自定义插件放在 $ZSH_CUSTOM/plugins/
# 不要加载太多插件，否则会影响 shell 启动速度
# -------------------------------------------------- #

# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
plugins=(
  z
  git
  aliases
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# https://ohmyz.sh/
source $ZSH/oh-my-zsh.sh

# -------------------------------------------------- #
# nvm 配置
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
# -------------------------------------------------- #
# https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# -------------------------------------------------- #
# 自定义别名
# -------------------------------------------------- #

# ------------------------- #
# Efficient Operation
# ------------------------- #

alias cmua='vim ~/.zshrc'

alias q='exit'
alias c='code .'
alias e.='explorer.exe .'

alias lsa='ls -a'
alias cls='clear'

# -------------------------------- #
# Directories
#
# I put
# `~/i` for my projects
# `~/f` for forks
# `~/w` for workspace
# -------------------------------- #

function i {
  cd ~/i/$1
}
function f {
  cd ~/f/$1
}
function w {
  cd ~/w/$1
}

# ------------------------- #
# Java run aliases
# ------------------------- #

alias mrun='mvn tomcat7:run'
alias mc='mvn clean'
alias mcu='mvn clean install -e -U'
alias p='mvn tomcat7:run -P pro-out'
alias out='mvn tomcat7:run -P out'

# ------------------------- #
# Node Package Manager
# ------------------------- #
# https://github.com/antfu/ni

alias nio='ni --prefer-offline'

alias r='nr -'
alias d='nr dev'
alias s='nr start'
alias b='nr build'
alias bw='nr build --watch'
alias t='nr test'
alias tu='nr test -u'
alias tw='nr test --watch'

alias h5='nr dev:h5'
alias weixin='nr dev:weixin'

alias lint='nr lint'
alias lintf='nr lint --fix'

alias up='npx taze major -wir'

# ------------------------- #
# Git aliases
# ------------------------- #

alias ginit='git init'

# Git user initialize
alias gcuinit="Set-GitUser"
function Set-GitUser {
  echo "Setting up Git user information."

  # Prompt user for name
  echo "Enter your name: \c"
  read UserName

  # Prompt user for email
  echo "Enter your email: \c"
  read UserEmail

  if [[ -n $UserName && -n $UserEmail ]]; then
    git config --global user.name "$UserName"
    git config --global user.email "$UserEmail"

    echo "Git user information has been set:"
    echo "Your name: $UserName"
    echo "Your email: $UserEmail"
  else
    echo "Name and email cannot be empty. Git user information has not been updated."
  fi
}

# Go to project root
alias grt='cd "$(git rev-parse --show-toplevel)"'

alias gcl='git clone'
alias gpl='git pull'
alias gp='git push'
alias gs='git status'
alias gl='git log'
alias glo='git log --oneline --graph'
alias gsh='git stash'
alias gshp='git stash pop'

alias ga='git add'
alias ga.='git add -A'
alias gcm='git commit -m'
alias gam='git add -A && git commit -m'

alias gb='git branch'
alias gbd='git branch -d'
alias gc='git checkout'
alias gcb='git checkout -b'

alias gme='git merge'
alias grh='git reset HEAD~1'

alias dev='git checkout develop'
alias main='git checkout main'
alias master='git checkout master'
