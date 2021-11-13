@echo off
rem A utility script to load personal assets.


rem Check whether PHP is available on the system.
php --version >nul || (
    echo No PHP on the system >&2
    exit /b 1
)

rem Get working directory of current batch script.
set cwd=%~dp0
rem Get path to executables.
set bin=%cwd%..\bin
rem Get path to library.
set lib=%cwd%..\lib
rem Get path to PHP scripts.
set libexec=%cwd%..\libexec
rem Get the root path.
set root=%cwd%..\..

rem Create a public directory if it doesn't exist.
if not exist %root%\public (
    mkdir %root%\public || (
        echo Unable to create a public directory >&2
        exit /b 1
    )
)

rem Load personal assets.
php %libexec%\assets.php || (
    exit /b %ERRORLEVEL%
)
