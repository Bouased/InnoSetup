@echo off

rem  Inno Setup
rem  Copyright (C) 1997-2012 Jordan Russell
rem  Portions by Martijn Laan
rem  For conditions of distribution and use, see LICENSE.TXT.
rem
rem  Batch file to compile all projects without Unicode support

setlocal

if exist compilesettings.bat goto compilesettingsfound
:compilesettingserror
echo compilesettings.bat is missing or incomplete. It needs to be created
echo with the following lines, adjusted for your system:
echo.
echo   set DELPHIROOT=c:\delphi2              [Path to Delphi 2 (or later)]
echo   set DELPHI3ROOT=c:\delphi3             [Path to Delphi 3 (or later)]
echo   set DELPHI7ROOT=c:\delphi7             [Path to Delphi 7 (or later)]
goto failed2

:compilesettingsfound
set DELPHIROOT=
set DELPHI3ROOT=
set DELPHI7ROOT=
call .\compilesettings.bat
if "%DELPHIROOT%"=="" goto compilesettingserror
if "%DELPHI3ROOT%"=="" goto compilesettingserror
if "%DELPHI7ROOT%"=="" goto compilesettingserror

rem -------------------------------------------------------------------------

rem  Compile each project separately because it seems Delphi
rem  carries some settings (e.g. $APPTYPE) between projects
rem  if multiple projects are specified on the command line.

cd Projects
if errorlevel 1 goto exit


cd Common
::call .\CompileRC.bat ansi
if errorlevel 1 goto exit

cd ..

cd Delphi
if errorlevel 1 goto exit

echo - ISPP.dpr
"%DELPHI7ROOT%\bin\dcc32.exe" -Q -B -H -W %1 -I"%INCLUDES%" -O"%OBJS%" -R"%RESOURCES%" -U"%DELPHI7ROOT%\lib" -U"%DIRECTORIES_ANSI%" -E..\..\Files -N..\..\Dcu ISPP.dpr -DIS_ALLOWD7
if errorlevel 1 goto failed

echo - Compil32.dpr
"%DELPHI3ROOT%\bin\dcc32.exe" -Q -B -H -W %1 -I"%INCLUDES%" -O"%OBJS%" -R"%RESOURCES%" -U"%DELPHI3ROOT%\lib" -U"%DIRECTORIES_ANSI%" -E..\..\Files -N..\..\Dcu -DPS_MINIVCL;PS_NOWIDESTRING;PS_NOINT64;PS_NOGRAPHCONST Compil32.dpr
if errorlevel 1 goto failed

echo - ISCC.dpr
"%DELPHIROOT%\bin\dcc32.exe" -Q -B -H -W %1 -I"%INCLUDES%" -O"%OBJS%" -R"%RESOURCES%" -U"%DELPHIROOT%\lib" -U"%DIRECTORIES_ANSI%" -E..\..\Files -N..\..\Dcu -DPS_MINIVCL;PS_NOWIDESTRING;PS_NOINT64;PS_NOGRAPHCONST ISCC.dpr
if errorlevel 1 goto failed
echo - ISCmplr.dpr
"%DELPHIROOT%\bin\dcc32.exe" -Q -B -H -W %1 -I"%INCLUDES%" -O"%OBJS%" -R"%RESOURCES%" -U"%DELPHIROOT%\lib" -U"%DIRECTORIES_ANSI%" -E..\..\Files -N..\..\Dcu -DPS_MINIVCL;PS_NOWIDESTRING;PS_NOINT64;PS_NOGRAPHCONST ISCmplr.dpr
if errorlevel 1 goto failed

echo - SetupLdr.dpr
"%DELPHIROOT%\bin\dcc32.exe" -Q -B -H -W %1 -I"%INCLUDES%" -O"%OBJS%" -R"%RESOURCES%" -U"%DELPHIROOT%\lib" -U"%DIRECTORIES_ANSI%" -E..\..\Files -N..\..\Dcu SetupLdr.dpr
if errorlevel 1 goto failed

echo - Setup.dpr
"%DELPHIROOT%\bin\dcc32.exe" -Q -B -H -W %1 -I"%INCLUDES%" -O"%OBJS%" -R"%RESOURCES%" -U"%DELPHIROOT%\lib" -U"%DIRECTORIES_ANSI%" -E..\..\Files -N..\..\Dcu -DPS_MINIVCL;PS_NOWIDESTRING;PS_NOINT64;PS_NOGRAPHCONST Setup.dpr
if errorlevel 1 goto failed

echo - Renaming files
cd ..\..\Files
if errorlevel 1 goto failed
move SetupLdr.exe SetupLdr.e32
if errorlevel 1 goto failed
move Setup.exe Setup.e32
if errorlevel 1 goto failed

echo - StripReloc'ing
%stripreloc% /b- Compil32.exe ISCC.exe SetupLdr.e32 Setup.e32
if errorlevel 1 goto failed

echo Success!
cd ..
goto exit

:failed
echo *** FAILED ***
cd ..
:failed2
exit /b 1

:exit
