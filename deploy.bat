@echo off
echo Deploying to Vercel...
cd /d "%~dp0"
vercel --prod --yes
echo.
echo Done! Check the URL above to see your live site.
pause
