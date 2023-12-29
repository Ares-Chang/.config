# PowerShell 文档 https://learn.microsoft.com/zh-cn/powershell/scripting/learn/ps101/00-introduction?view=powershell-7.4
# 配置文件文档 https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.4
# 比较运算符 https://learn.microsoft.com/zh-cn/powershell/scripting/learn/ps101/05-formatting-aliases-providers-comparison?view=powershell-7.4#comparison-operators

if (!(Test-Path -Path $PROFILE)) {
  New-Item -ItemType File -Path $PROFILE -Force
}

# -------------------------------------------------- #
# 主题设置
# -------------------------------------------------- #

# ------------------------- #
# oh-my-posh
# ------------------------- #
# https://ohmyposh.dev/

# 设置 Theme 目录下随机主题
# $theme = Get-ChildItem $env:POSH_THEMES_PATH | Get-Random
# Write-Output "Hello! Today's lucky theme is $theme :)"
# oh-my-posh init pwsh --config $theme | Invoke-Expression

# ------------------------- #
# starship
# ------------------------- #
# https://starship.rs/zh-CN/
Invoke-Expression (&starship init powershell)

# 开启文件/文件夹图标 https://github.com/devblackops/Terminal-Icons
Import-Module -Name Terminal-Icons

# -------------------------------------------------- #
# 导入插件
# -------------------------------------------------- #

# ------------------------- #
# PSReadLine
# ------------------------- #
# https://github.com/PowerShell/PSReadLine
# 设置 Tab 为补全的快捷键
# Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete
# 设置 Ctrl + Z 为撤销
Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo

# ------------------------- #
# 开启 git 命令补全
# ------------------------- #
# https://github.com/dahlbyk/posh-git
# Import-Module posh-git

# ------------------------- #
# z
# ------------------------- #
# https://github.com/badmotorfinger/z
Import-Module z 

# ------------------------- #
# 语法高亮
# ------------------------- #
Import-Module syntax-highlighting

# ------------------------- #
# 修复 ni 命令被占用
# ------------------------- #
# https://github.com/antfu/ni

Remove-Item Alias:ni -Force -ErrorAction Ignore
$profileEntry = 'Remove-Item Alias:ni -Force -ErrorAction Ignore'
$profileContent = Get-Content $profile
if ($profileContent -notcontains $profileEntry) {
  ("`n" + $profileEntry) | Out-File $profile -Append -Force -Encoding UTF8
}

# -------------------------------------------------- #
# 自定义别名
# -------------------------------------------------- #
# https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.utility/set-alias?view=powershell-7.3

# ------------------------- #
# Efficient Operation
# ------------------------- #

# 查看环境变量
Set-Alias env CatEnv
function CatEnv {
  Get-ChildItem Env: | Format-Table -AutoSize
}

# 打开配置
Set-Alias cmua OpenPROFile
function OpenPROFile {
  if (Get-Command vim -ErrorAction SilentlyContinue) {
    vim $PROFILE
  }
  elseif (Get-Command nvim -ErrorAction SilentlyContinue) {
    nvim $PROFILE
  }
  elseif (Get-Command code -ErrorAction SilentlyContinue) {
    code $PROFILE
  }
  else {
    notepad $PROFILE
  }
}

# 重新加载配置
Set-Alias reload ReloadProfile
function ReloadProfile {
  . $PROFILE
}

# 返回 home 目录
Set-Alias ~ GoHome
function GoHome {
  Set-Location $env:USERPROFILE
}

# cd 到 project 目录/指定目录
Set-Alias project GoProject
function GoProject([string]$catalog) {
  if ([string]::IsNullOrWhiteSpace($catalog)) {
    Set-Location $env:USERPROFILE/project
  }
  else {
    $path = "$env:USERPROFILE/project/$catalog"
    if ($path -and (Test-Path $path -PathType Container)) {
      Set-Location $path
    } 
    else {
      Write-Host "路径无效，无法进行跳转"
    }
  }
}

# 退出
Set-Alias q UseExit
function UseExit {
  exit
}

Set-Alias ip ipconfig

# 使用 VS Code 打开目录/文件
Set-Alias c OpenFile
function OpenFile {
  code .
}

# 使用 explorer 打开目录
Set-Alias e. OpenExplorer
function OpenExplorer {
  explorer .
}

Set-Alias helloworld Hello
function Hello([string]$text = "Hello, World!") {
  npx figlet $text
}

# ------------------------- #
# nvim
# ------------------------- #

Set-Alias vi nvim
Set-Alias vim nvim

# ------------------------- #
# Java run aliases
# ------------------------- #

Set-Alias mrun MvnRun
function MvnRun {
  mvn tomcat7:run @Args
}

Set-Alias mc MvnClean
function MvnClean {
  mvn clean @Args
}

Set-Alias mcu MvnCleanInstall
function MvnCleanInstall {
  mvn clean install -e -U @Args
}

Set-Alias p MvnProOut
function MvnProOut {
  mvn tomcat7:run -P pro-out @Args
}

Set-Alias out MvnOut
function MvnOut {
  mvn tomcat7:run -P out @Args
}

# ------------------------- #
# Node Package Manager
# ------------------------- #
# https://github.com/antfu/ni

Set-Alias r NrLastModel
function NrLastModel {
  nr -
}

Set-Alias d NrDev
function NrDev {
  nr dev @Args
}

Set-Alias s NrStart
function NrStart {
  nr start @Args
}

Set-Alias b NrBuild
function NrBuild {
  nr build @Args
}

Set-Alias bw NrBuildWatch
function NrBuildWatch {
  nr build --watch @Args
}

Set-Alias h5 NrDevH5
function NrDevH5 {
  nr dev:h5 @Args
}

Set-Alias weixin NrDevMpWeixin
function NrDevMpWeixin {
  nr dev:mp-weixin @Args
}

Set-Alias t NrTest
function NrTest {
  nr test @Args
}

Set-Alias tu NrTestU
function NrTestU {
  nr test -u @Args
}

Set-Alias tw NrTestWatch
function NrTestWatch {
  nr test --watch @Args
}

Set-Alias lint NrLint
function NrLint {
  nr lint @Args
}

Set-Alias lintf NrLintFix
function NrLintFix {
  nr lint --fix @Args
}

Set-Alias up NpmUpgrade
function NpmUpgrade {
  npx taze major -wir
}

# ------------------------- #
# Git aliases
# ------------------------- #

Set-Alias ginit GitInit
function GitInit {
  git init
}

Set-Alias gcuinit Set-GitUser
function Set-GitUser {
  $currentCulture = $PSCulture.Name
  $useChinesePrompt = $currentCulture -eq "zh-CN"
  $prompt = if ($useChinesePrompt) {
    @("设置 Git 用户信息。", "请输入您的姓名：", "请输入您的邮箱：", "Git 用户信息已设置。", "姓名和邮箱不能为空。Git 用户信息未更新.")
  }
  else {
    @("Setting up Git user information.", "Enter your name: ", "Enter your email: ", "Git user information has been set.", "Name and email cannot be empty. Git user information has not been updated.")
  }

  Write-Host $prompt[0]
  $UserName = Read-Host $prompt[1]
  $UserEmail = Read-Host $prompt[2]

  if (-not [string]::IsNullOrWhiteSpace($UserName) -and -not [string]::IsNullOrWhiteSpace($UserEmail)) {
    git config --global user.name $UserName
    git config --global user.email $UserEmail

    Write-Host $prompt[3]
    Write-Host "Your name: $UserName"
    Write-Host "Your email: $UserEmail"
  }
  else {
    Write-Host $prompt[4]
  }
}

# Go to project root
Set-Alias grt GitRoot
function GitRoot {
  $path = $(git rev-parse --show-toplevel)
  # 这里需要做个判断，$path 是否获取成功，失败就不跳转
  try {
    if ($path -and (Test-Path $path -PathType Container)) {
      Set-Location $path
    }
    else {
      Write-Host "路径无效，无法进行跳转"
    }
  }
  catch {
    Write-Host "处理路径时出现错误: $_"
  }
}

Set-Alias gpl GitPull
function GitPull {
  git pull @Args
}

Set-Alias gp GitPush -Force
function GitPush {
  git push @Args
}

Set-Alias gs GitStatus
function GitStatus {
  git status @Args
}

Set-Alias gl GitLog -Force
function GitLog {
  git log @Args
}

Set-Alias glo GitLogOnline
function GitLogOnline {
  git log --oneline --graph @Args
}

Set-Alias ga GitAdd
function GitAdd {
  if ($Args.Count -eq 0) {
    git add .
  }
  else {
    git add @Args
  }
}

Set-Alias ga. GitAddAll
function GitAddAll {
  git add -A
}

Set-Alias gcm GitCommit -Force
function GitCommit {
  git commit -m @Args
}

Set-Alias gam GitAddCommit
function GitAddCommit {
  git add -A && git commit -m @Args
}

Set-Alias gcl GitClone
function GitClone {
  git clone @Args
}

Set-Alias gsh GitStash
function GitStash {
  git stash @Args
}

Set-Alias gshp GitStashPop
function GitStashPop {
  git stash pop
}

Set-Alias gb GitBranch
function GitBranch {
  git branch @Args
}

Set-Alias gbd GitBranchDelete
function GitBranchDelete {
  git branch -d @Args
}

Set-Alias gme GitMerge
function GitMerge {
  git merge @Args
}

Set-Alias gc GitCheckout -Force
function GitCheckout {
  git checkout @Args
}

Set-Alias gcb GitCheckoutBranch
function GitCheckoutBranch {
  git checkout -b @Args
}

Set-Alias master GitCheckoutMaster
Set-Alias main GitCheckoutMaster
function GitCheckoutMaster {
  $branchList = git branch --list "master"
  $mainBranchList = git branch --list "main"

  if ($branchList -and $mainBranchList) {
    git checkout master
  }
  elseif ($mainBranchList) {
    git checkout main
  }
  else {
    git checkout master
  }
}

Set-Alias dev GitCheckoutDev
function GitCheckoutDev {
  git checkout develop
}

Set-Alias grh GitReset
function GitReset {
  git reset HEAD~1
}
