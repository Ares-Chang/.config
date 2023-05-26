;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below here
e.=explorer .
gl=git log --oneline --all --graph --decorate  $*
l=ls --show-control-chars -CFGNhp --color --ignore={"NTUSER.DAT*","ntuser.dat*"} $*
ls=ls --show-control-chars -F --color $*
pwd=cd
clear=cls
unalias=alias /d $1
vi=nvim $*
vim=nvim $*
cmderr=cd /d "%CMDER_ROOT%"
pwsh=%SystemRoot%/System32/WindowsPowerShell/v1.0/powershell.exe -ExecutionPolicy Bypass -NoLogo -NoProfile -NoExit -Command "Invoke-Expression '. ''%CMDER_ROOT%/vendor/profile.ps1'''"

;= rem Efficient operation
cmua=nvim "%CMDER_ROOT%"\config\user_aliases.cmd
q=exit
c=code .

;= rem JAVA run aliases
mrun=mvn tomcat7:run $*
mc=mvn clean
~=cd C:\Users\%USERNAME%
p=mvn tomcat7:run -P pro-out
out=mvn tomcat7:run -P out

;= rem npm aliases
r=nr -
d=nr dev $*
b=nr build $*
lint=nr lint
lintf=nr lint --fix

;= rem git aliases

gpl=git pull $*
gp=git push $*

gs=git status $*
gl=git log
ga=git add .
gcm=git commit -m $*
gcam=git add -A && git commit -m $*

gcl=git clone $*
gst=git stash $*

gb=git branch $*
gbd=git branch -d $*

gc=git checkout $*
gcb=git checkout -b $*

grh=git reset HEAD~1
