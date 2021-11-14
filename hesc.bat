@echo off
If "%1%"=="d" goto Deploy
If "%1%"=="s" goto Server
If "%1%"=="g" goto Generate
If "%1%"=="b" goto Backup
If "%1%"=="ex" goto DeployAndBackup
goto Endif

:Deploy
hexo clean && hexo g && hexo d
goto Endif

:Server
hexo clean && hexo g && hexo s
goto Endif

:Generate
hexo clean && hexo g
goto Endif

:Backup
set message="Backup updated at %DATE%"
git checkout source && git add * && git commit -m %message% && git push origin source
goto Endif

:DeployAndBackup
hexo clean && hexo g && hexo d
set message="Backup updated at %DATE%"
git checkout source && git add * && git commit -m %message% && git push origin source
goto Endif

:Endif