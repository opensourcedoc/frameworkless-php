@echo off
rem Sync a local PHP site to a production environment.
rem  Unrequired directories and files are skipped.


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

rem Check whether rsync is available on the system.
rsync --version >nul || (
    echo No rsync on the system >&2
    exit /b 1
)

set dest=%1
if "" == "%dest%" (
    echo No destination >&2
    exit /b 1
)

if not exist %dest% (
    echo Invalid destination: %dest% >&2
    exit /b 1
)

rem Get working directory of current batch script.
set cwd=%~dp0
rem Get the path to the tool executables.
set bin=%cwd%..\bin
rem Get the path to the tool library.
set lib=%cwd%..\lib
rem Get the path to the PHP scripts.
set libexec=%cwd%..\libexec
rem Get the root path.
set root=%cwd%..\..

rem Download third-party PHP packages if they don't exist.
if not exist %root%\vendor (
    call composer install --no-dev || (
        exit /b %ERRORLEVEL%
    )
)

rem Delete old public files.
del /s /q %root%\public || (
    echo Unable to delete public directory >&2
    exit /b 1
)

rem Load assets.
call %bin%\assets.bat || (
    exit /b %ERRORLEVEL%
)

rem Copy static files.
xcopy /s /y %root%\static %root%\public || (
    echo Unable to copy static files to the public directory >&2
    exit /b 1
)

rem Trick for rsync on Windows.
set source=%root:C:\=\cygdrive\c\%\
set target=%dest:C:\=\cygdrive\c\%
set source=%source:\=/%
set target=%target:\=/%

rem Sync directories and files between the source
rem  and the destination.
rem
rem Directories and files on the destination may be deleted.
rem  Don't edit them on production environments.
rsync -rvh --delete ^
    --exclude ".git*" ^
    --exclude tools --exclude assets --exclude build --exclude static ^
    --exclude composer.json --exclude composer.lock ^
    --exclude LICENSE --exclude README.md --exclude TODO.md ^
    --exclude package.json --exclude package-lock.json --exclude node_modules ^
    --exclude .browserlistrc --exclude .stylelintrc ^
    --exclude .eslintrc --exclude .flowconfig ^
    %source% %target%
