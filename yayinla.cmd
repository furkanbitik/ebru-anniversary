@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"

rem  Kullanim:  yayinla "commit mesaji"
rem  Mesaj yazilmazsa varsayilan mesaj kullanilir.
set "MSG=%~1"
if "%MSG%"=="" set "MSG=site guncellendi"

echo.
echo [1/3] Degisiklikler hazirlaniyor...
git add -A
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "%MSG%" || goto :hata
) else (
    echo       Commit edilecek yeni degisiklik yok.
)

echo.
echo [2/3] GitHub'a gonderiliyor...
git push origin main || goto :hata

echo.
echo [3/3] Cloudflare'e yayinlaniyor...
call npx wrangler deploy || goto :hata

echo.
echo ======================================
echo  TAMAM - site guncellendi
echo  https://ebrulovefurkan.furkanbitik2.workers.dev
echo ======================================
exit /b 0

:hata
echo.
echo !! Bir adim basarisiz oldu, yukaridaki mesaja bak.
exit /b 1
