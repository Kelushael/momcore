@echo off
title M.O.M.-CORE
color 0D
echo.
echo    ========================================
echo    =                                      =
echo    =        M.O.M. - CORE                 =
echo    =        Starting up...                =
echo    =                                      =
echo    ========================================
echo.

:: Make sure Ollama is running
echo    Starting AI engine...
start /min "" ollama serve 2>nul
timeout /t 3 /nobreak >nul

:: Start the app
cd /d "%~dp0"
echo    Launching M.O.M.-CORE...
echo.
echo    Your browser will open in a moment.
echo    If it doesn't, go to:
echo    http://localhost:5173
echo.
echo    ========================================
echo    =  DO NOT CLOSE THIS WINDOW while      =
echo    =  using M.O.M.-CORE. Minimize it.     =
echo    ========================================
echo.

:: Open browser after a short delay
start "" http://localhost:5173

:: Run the dev server
npx vite --host
