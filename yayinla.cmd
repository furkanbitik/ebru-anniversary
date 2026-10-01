@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"

echo.
echo ============================================
echo   Ebru ^& Furkan — Siteyi Canliya Alma
echo ============================================
echo.

set "MSG=%~1"
if "%MSG%"=="" set "MSG=3. ve 4. ay sayfalari aktif edildi"

echo [1/3] Degisiklikler Git'e kaydediliyor...
git add -A
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "%MSG%"
) else (
    echo       Kaydedilecek yeni degisiklik yok, devam ediliyor.
)

echo.
echo [2/3] GitHub'a gonderiliyor...
git push origin main

echo.
echo [3/3] Cloudflare oturumu kontrol ediliyor...
call npx wrangler whoami >nul 2>&1
if errorlevel 1 (
    echo.
    echo [*] Cloudflare oturumunun suresi dolmus.
    echo [*] Tarayiciniz acilacak, lutfen acilan sayfada 'Allow' (Yetkilendir) butonuna tiklayin...
    echo.
    call npx wrangler login || goto :hata
)

echo.
echo [*] Cloudflare Workers uzerine yayinlaniyor...
call npx wrangler deploy || goto :hata

echo.
echo ============================================
echo  TEBRIKLER! Site basariyla guncellendi:
echo  https://ebrulovefurkan.furkanbitik2.workers.dev
echo ============================================
echo.
pause
exit /b 0

:hata
echo.
echo ============================================
echo  !! Bir adimda hata olustu.
echo ============================================
echo.
pause
exit /b 1
