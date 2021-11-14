@echo off
rem Publish a mdmcs site to a PaaS.


rem Check whether PHP is available on the system.
php --version >nul || (
    echo No PHP on the system >&2
    exit /b 1
)

rem Check whether Composer is available on the system.
call composer --version >nul || (
    echo No Composer on the system >&2
    exit /b 1
)

set address=%1
if "" == "%address%" (
    set address=localhost:5000
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

rem Download third-party PHP packages if they don't exist.
if not exist %root%\vendor (
    call composer install --no-dev || (
        exit /b %ERRORLEVEL%
    )
)

rem Load theme assets.
call %bin%\assets.bat || (
    exit /b %ERRORLEVEL%
)

rem Copy static files.
xcopy /s /y %root%\static %root%\public || (
    echo Unable to copy static files to the public directory >&2
    exit /b 1
)

rem Copy PHP scripts.
xcopy /s /y %root%\www %root%\public || (
    echo Unable to copy PHP scripts to public directory >&2
    exit /b 1
)
