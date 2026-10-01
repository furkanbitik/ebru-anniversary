@echo off
chcp 65001 >nul
setlocal EnableExtensions
cd /d "%~dp0"

rem ============================================================
rem  Ebru & Furkan - Siteyi tek tikla yayinlama
rem  1) Degisiklikleri commit eder
rem  2) GitHub'a gonderir (gerekirse once uzaktaki degisiklikleri ceker)
rem  3) Cloudflare Workers'a yayinlar
rem  4) Canli siteyi klasordeki index.html ile karsilastirir
rem  Kullanim:  yayinla.cmd            (otomatik mesaj)
rem             yayinla.cmd "mesaj"    (kendi commit mesajin)
rem ============================================================

set "SITE=https://ebrulovefurkan.furkanbitik2.workers.dev"
set "S_COMMIT=-"
set "S_PUSH=-"
set "S_CF=-"
set "S_CHECK=-"
set "SONUC=0"

echo.
echo ============================================
echo   Ebru ^& Furkan - Siteyi Canliya Alma
echo ============================================
echo.

rem --- On kontroller ---------------------------------------------
where git >nul 2>&1 || (echo [X] Git bulunamadi. Git kurulu mu? & set "S_COMMIT=HATA - git yok" & goto :ozet)
where npx >nul 2>&1 || (echo [X] Node.js / npx bulunamadi. Node.js kurulu mu? & set "S_CF=HATA - npx yok")

rem Yarim kalmis bir git isleminden kalan kilit dosyasini temizle
if exist ".git\index.lock" (
    echo [*] Eski git kilit dosyasi bulundu, siliniyor...
    del /f /q ".git\index.lock" >nul 2>&1
)

rem --- Commit mesaji ---------------------------------------------
set "MSG=%~1"
if not "%MSG%"=="" goto :commit
for /f "delims=" %%i in ('powershell -NoProfile -Command "Get-Date -Format 'yyyy-MM-dd HH:mm'"') do set "NOW=%%i"
set "MSG=Site guncellendi - %NOW%"

rem --- 1) Commit -------------------------------------------------
:commit
echo [1/4] Degisiklikler Git'e kaydediliyor...
git add -A
if errorlevel 1 (set "S_COMMIT=HATA - git add" & set "SONUC=1" & goto :push)
git diff --cached --quiet
if not errorlevel 1 (
    echo       Yeni degisiklik yok.
    set "S_COMMIT=OK - yeni degisiklik yoktu"
    goto :push
)
git commit -q -m "%MSG%"
if errorlevel 1 (set "S_COMMIT=HATA - commit yapilamadi" & set "SONUC=1" & goto :push)
set "S_COMMIT=OK - %MSG%"
echo       Kaydedildi: %MSG%

rem --- 2) GitHub push --------------------------------------------
:push
echo.
echo [2/4] GitHub'a gonderiliyor...
git push origin main
if not errorlevel 1 (set "S_PUSH=OK" & goto :cloudflare)

echo       Ilk deneme basarisiz. GitHub'daki degisiklikler cekilip tekrar deneniyor...
git pull --rebase --autostash origin main
if errorlevel 1 (
    git rebase --abort >nul 2>&1
    set "S_PUSH=HATA - GitHub ile cakisma var, elle cozulmeli"
    set "SONUC=1"
    goto :cloudflare
)
git push origin main
if errorlevel 1 (set "S_PUSH=HATA - gonderilemedi, internet/GitHub girisini kontrol et" & set "SONUC=1" & goto :cloudflare)
set "S_PUSH=OK - uzaktaki degisikliklerle birlestirildi"

rem --- 3) Cloudflare deploy --------------------------------------
:cloudflare
if not "%S_CF%"=="-" (set "SONUC=1" & goto :ozet)
echo.
echo [3/4] Cloudflare oturumu kontrol ediliyor...
call npx wrangler whoami >nul 2>&1
if not errorlevel 1 goto :deploy
echo       Oturum suresi dolmus. Tarayici acilacak, 'Allow' butonuna tiklayin...
call npx wrangler login
if errorlevel 1 (set "S_CF=HATA - Cloudflare girisi yapilamadi" & set "SONUC=1" & goto :ozet)

:deploy
echo       Cloudflare Workers'a yayinlaniyor...
call npx wrangler deploy
if errorlevel 1 (set "S_CF=HATA - wrangler deploy basarisiz" & set "SONUC=1" & goto :ozet)
set "S_CF=OK"

rem --- 4) Canli site kontrolu ------------------------------------
echo.
echo [4/4] Canli site kontrol ediliyor...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$u='%SITE%/?nocache='+[guid]::NewGuid(); $t=Join-Path $env:TEMP 'ebru_live.html'; $local=(Get-FileHash 'public\index.html').Hash;" ^
  "for($i=1; $i -le 5; $i++){ try{ Invoke-WebRequest -Uri $u -OutFile $t -UseBasicParsing -TimeoutSec 20 -Headers @{'Cache-Control'='no-cache'}; if((Get-FileHash $t).Hash -eq $local){ exit 0 } } catch { $script:err=1 }; Start-Sleep -Seconds 3 };" ^
  "if($script:err){ exit 1 } else { exit 2 }"
set "CHK=%errorlevel%"
if "%CHK%"=="0" set "S_CHECK=OK - canli site klasorle ayni"
if "%CHK%"=="1" (set "S_CHECK=UYARI - siteye ulasilamadi" & set "SONUC=1")
if "%CHK%"=="2" set "S_CHECK=UYARI - icerik farkli, birkac dakika sonra tekrar bak (onbellek)"

rem --- Ozet ------------------------------------------------------
:ozet
echo.
echo ============================================
echo   SONUC
echo ============================================
echo   Commit     : %S_COMMIT%
echo   GitHub     : %S_PUSH%
echo   Cloudflare : %S_CF%
echo   Canli site : %S_CHECK%
echo --------------------------------------------
if "%SONUC%"=="0" (
    powershell -NoProfile -Command "Write-Host '  TEBRIKLER! Site basariyla guncellendi.' -ForegroundColor Green"
    echo   %SITE%
) else (
    powershell -NoProfile -Command "Write-Host '  !! Bazi adimlar basarisiz oldu, yukaridaki mesajlara bakin.' -ForegroundColor Red"
)
echo ============================================
echo.
pause
exit /b %SONUC%
