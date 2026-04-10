@echo off
title M.O.M.-CORE Installer
color 0B
echo.
echo    ============================================
echo    =                                          =
echo    =       M.O.M. - CORE  INSTALLER           =
echo    =       Sales Intelligence Canvas           =
echo    =                                          =
echo    =       Made with love by Marcus            =
echo    ============================================
echo.
echo    Hey Mom! Just sit tight, I'm setting
echo    everything up for you. This only needs
echo    to run ONCE. Grab some coffee :)
echo.
echo -----------------------------------------------
echo  Step 1 of 5: Checking for Node.js...
echo -----------------------------------------------
where node >nul 2>&1
if %errorlevel%==0 (
    echo    [OK] Node.js is already installed!
    node --version
) else (
    echo    Node.js not found. Installing now...
    echo    (A window might pop up - that's normal!)
    winget install OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements
    if %errorlevel% neq 0 (
        echo.
        echo    [!] Couldn't auto-install Node.js.
        echo    Please go to https://nodejs.org and
        echo    download the LTS version, install it,
        echo    then run this script again.
        echo.
        pause
        exit /b 1
    )
    echo    [OK] Node.js installed!
    echo    NOTE: You may need to close and reopen
    echo    this window, then run install.bat again
    echo    for Node to be recognized.
)

echo.
echo -----------------------------------------------
echo  Step 2 of 5: Checking for Ollama (local AI)...
echo -----------------------------------------------
where ollama >nul 2>&1
if %errorlevel%==0 (
    echo    [OK] Ollama is already installed!
) else (
    echo    Ollama not found. Installing now...
    winget install Ollama.Ollama --accept-source-agreements --accept-package-agreements
    if %errorlevel% neq 0 (
        echo.
        echo    [!] Couldn't auto-install Ollama.
        echo    Please go to https://ollama.com and
        echo    download it, install it, then run
        echo    this script again.
        echo.
        pause
        exit /b 1
    )
    echo    [OK] Ollama installed!
    echo.
    echo    IMPORTANT: Please RESTART your computer
    echo    after Ollama installs, then run this
    echo    script one more time.
    echo.
    pause
    exit /b 0
)

echo.
echo -----------------------------------------------
echo  Step 3 of 5: Downloading AI brain (one time)...
echo -----------------------------------------------
echo    This downloads a small AI model (~1.5 GB).
echo    It only happens once. Might take a few minutes
echo    depending on your internet.
echo.
ollama pull hf.co/unsloth/DeepSeek-R1-Distill-Qwen-1.5B-GGUF:BF16
if %errorlevel%==0 (
    echo    [OK] AI model downloaded!
) else (
    echo    [!] Model download had an issue.
    echo    Make sure Ollama is running (check your
    echo    system tray for the llama icon) and try again.
    pause
    exit /b 1
)

echo.
echo -----------------------------------------------
echo  Step 4 of 5: Installing app packages...
echo -----------------------------------------------
cd /d "%~dp0"
call npm install
if %errorlevel%==0 (
    echo    [OK] All packages installed!
) else (
    echo    [!] Package install had an issue.
    echo    Try running this script again.
    pause
    exit /b 1
)

echo.
echo -----------------------------------------------
echo  Step 5 of 5: Creating desktop shortcut...
echo -----------------------------------------------
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%temp%\shortcut.vbs"
echo sLinkFile = oWS.SpecialFolders("Desktop") ^& "\M.O.M.-CORE.lnk" >> "%temp%\shortcut.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%temp%\shortcut.vbs"
echo oLink.TargetPath = "%~dp0start.bat" >> "%temp%\shortcut.vbs"
echo oLink.WorkingDirectory = "%~dp0" >> "%temp%\shortcut.vbs"
echo oLink.Description = "M.O.M. - Sales Intelligence Canvas" >> "%temp%\shortcut.vbs"
echo oLink.Save >> "%temp%\shortcut.vbs"
cscript //nologo "%temp%\shortcut.vbs"
del "%temp%\shortcut.vbs"
echo    [OK] Shortcut "M.O.M.-CORE" added to Desktop!

echo.
echo    ============================================
echo    =                                          =
echo    =         ALL DONE! You're ready!          =
echo    =                                          =
echo    =   Double-click "M.O.M.-CORE" on your    =
echo    =   Desktop to launch anytime.             =
echo    =                                          =
echo    =   Or just double-click START.BAT in      =
echo    =   this folder.                           =
echo    =                                          =
echo    ============================================
echo.
pause
