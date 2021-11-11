@echo off
If "%1%"=="d" goto Deploy
If "%1%"=="s" goto Server
If "%1%"=="g" goto Generate
If "%1%"=="b" goto Backup
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
git checkout source && git add * && git commit -m %2% && git push origin source
goto Endif

:Endif