@echo off
setlocal
title BlueStacks Auto-Rooter (100% Seguro)

echo ========================================================
echo        BlueStacks Auto-Rooter (Seguro y Sin Corrupcion)
echo ========================================================
echo.

echo [+] Asegurando que el emulador este completamente cerrado...
echo [+] (Si el emulador esta abierto, modificar archivos causa corrupcion)
taskkill /F /IM HD-Player.exe >nul 2>&1
taskkill /F /IM HD-Agent.exe >nul 2>&1
taskkill /F /IM BlueStacks.exe >nul 2>&1
taskkill /F /IM BlueStacksX.exe >nul 2>&1
taskkill /F /IM BstkSVC.exe >nul 2>&1
taskkill /F /IM HD-Adb.exe >nul 2>&1
timeout /t 4 >nul

set "ps1=%temp%\root_bs.ps1"

echo $ErrorActionPreference = 'SilentlyContinue' > "%ps1%"
echo $utf8NoBom = New-Object System.Text.UTF8Encoding($false) >> "%ps1%"
echo $confPaths = @( >> "%ps1%"
echo     "C:\ProgramData\BlueStacks_nxt\bluestacks.conf", >> "%ps1%"
echo     "C:\ProgramData\BlueStacks\bluestacks.conf", >> "%ps1%"
echo     "C:\ProgramData\BlueStacks_msi5\bluestacks.conf" >> "%ps1%"
echo ) >> "%ps1%"
echo foreach ($path in $confPaths) { >> "%ps1%"
echo     if (Test-Path $path) { >> "%ps1%"
echo         Write-Host "  [+] Parcheando config: $path" -ForegroundColor Green >> "%ps1%"
echo         $content = [System.IO.File]::ReadAllText($path) >> "%ps1%"
echo         $content = $content.Replace('bst.feature.rooting="0"', 'bst.feature.rooting="1"') >> "%ps1%"
echo         $content = $content.Replace('enable_root_access="0"', 'enable_root_access="1"') >> "%ps1%"
echo         [System.IO.File]::WriteAllText($path, $content, $utf8NoBom) >> "%ps1%"
echo     } >> "%ps1%"
echo } >> "%ps1%"

echo $enginePaths = @( >> "%ps1%"
echo     "C:\ProgramData\BlueStacks_nxt\Engine", >> "%ps1%"
echo     "C:\ProgramData\BlueStacks\Engine", >> "%ps1%"
echo     "C:\ProgramData\BlueStacks_msi5\Engine" >> "%ps1%"
echo ) >> "%ps1%"
echo foreach ($ep in $enginePaths) { >> "%ps1%"
echo     if (Test-Path $ep) { >> "%ps1%"
echo         $files = Get-ChildItem -Path $ep -Include "*.bstk", "*.bstk-prev", "Android.bstk.in" -Recurse >> "%ps1%"
echo         foreach ($file in $files) { >> "%ps1%"
echo             Write-Host "  [+] Parcheando engine: $($file.FullName)" -ForegroundColor Cyan >> "%ps1%"
echo             $content = [System.IO.File]::ReadAllText($file.FullName) >> "%ps1%"
echo             $content = $content -replace 'type="Readonly"', 'type="Normal"' >> "%ps1%"
echo             $content = $content -replace "type='Readonly'", "type='Normal'" >> "%ps1%"
echo             $content = $content -replace "type=Readonly", "type=Normal" >> "%ps1%"
echo             [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom) >> "%ps1%"
echo         } >> "%ps1%"
echo     } >> "%ps1%"
echo } >> "%ps1%"

echo [+] Aplicando Root...
powershell -NoProfile -ExecutionPolicy Bypass -File "%ps1%"
del "%ps1%"

echo.
echo [+] Proceso de Root Finalizado con Exito.
echo [+] Ya puedes abrir BlueStacks.
pause
